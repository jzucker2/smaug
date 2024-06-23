# smaug

Simple home automation template.

Fill out with some details.

Need to create a file at `/etc/environment` containing the followinfg for health checks:

```
DOCKER_LOCALHOST="host.docker.internal"
CADVISOR_EXTERNAL_PORT=8080
NODE_EXPORTER_EXTERNAL_PORT=9100
PROMTAIL_EXTERNAL_PORT=9080
```
