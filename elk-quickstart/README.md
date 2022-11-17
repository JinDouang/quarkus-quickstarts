Quarkus guide: https://quarkus.io/guides/opentelemetry

must add in /etc/hosts (vm/windows etc...) :

[ip] localdev kibana

test request : `curl http://localhost:8080/hello` or `curl http://localdev:8080/hello`

Launch your application, you should see your logs arriving inside the Elastic Stack; you can use Kibana available
at http://localhost:5601/ to access them.