#!/bin/bash

quarkus_container="myservice"
PORT=8080


startElk() {
 docker-compose up -d elasticsearch
 docker-compose up -d logstash
 docker-compose up -d kibana
}

stopElk() {
  docker-compose stop elasticsearch
  docker-compose stop logstash
  docker-compose stop kibana
}

runDev() {
  forceRemove;
  docker-compose run --rm -p $PORT:$PORT --name $quarkus_container maven sh -c "./mvnw quarkus:dev"
}

runDevDetach() {
  forceRemove;
  docker-compose run -d --rm -p $PORT:$PORT --name $quarkus_container maven sh -c "./mvnw quarkus:dev"
}

forceRemove() {
    docker rm $quarkus_container --force;
}

# only works on DETACH mode
logs() {
  docker logs -f myservice --since 0s;
}

for param in "$@"; do
  case $param in
  clean)
    clean
    ;;
  startElk)
    startElk
    ;;
  stopElk)
    stopElk
    ;;
  run)
    runDev
    ;;
  runDetach)
    runDevDetach
    ;;
  runDev)
    runDev
    ;;
  runDevDetach)
    runDevDetach
    ;;
  logs)
    logs
    ;;
  *)
    echo "Invalid argument : $param"
    ;;
  esac
  if [ ! $? -eq 0 ]; then
    exit 1
  fi
done