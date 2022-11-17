Quarkus guide: https://quarkus.io/guides/opentelemetry

must add in /etc/hosts (vm/windows etc...) :

[ip] localdev otel

test request : `curl http://localhost:8080/hello` or `curl http://localdev:8080/hello`