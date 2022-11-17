#!/bin/bash

quarkus_container="myservice"
PORT=8080


startLogs() {
 docker-compose up -d jaeger
# docker-compose up -d otel-collector
}

stopLogs() {
  docker-compose stop jaeger
#  docker-compose stop otel-collector
}

runDev() {
  forceRemove;
  docker-compose run --rm -p $PORT:$PORT --name $quarkus_container maven sh -c "./mvnw quarkus:dev"
}

runDevDetach() {
  forceRemove;
  docker-compose run -d --rm -p $PORT:$PORT --name $quarkus_container maven sh -c "./mvnw quarkus:dev -Dquarkus.http.host=0.0.0.0"
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
  startLogs)
    startLogs
    ;;
  stopLogs)
    stopLogs
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