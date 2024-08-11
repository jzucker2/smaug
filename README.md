# smaug

Simple home automation template.

Fill out with some details.

Need to create a file at `/etc/environment` containing the followinfg for health checks:

```
DOCKER_LOCALHOST="host.docker.internal"
HOME_ASSISTANT_EXTERNAL_PORT=8123
POSTGRES_DEFAULT_DB=home_assistant
POSTGRES_USER=foo
MOSQUITTO_EXTERNAL_PORT=1883
MOSQUITTO_EXPORTER_EXTERNAL_PORT=9234
MOSQUITTO_USER=hass
MOSQUITTO_PASSWORD=raspberry
ZIGBEE2MQTT_EXTERNAL_PORT=8777
NODE_RED_EXTERNAL_PORT=1880
NODE_RED_HEALTHCHECK_PORT=1881
ESPHOME_EXTERNAL_PORT=6052
GOVEE2MQTT_EXTERNAL_PORT=8056
CADVISOR_EXTERNAL_PORT=8080
NODE_EXPORTER_EXTERNAL_PORT=9100
PROMTAIL_EXTERNAL_PORT=9080
```

To set up small other things:

```
git config --global user.name "First Lastname"
git config --global user.email "<email>@provider.com"
git config --global credential.helper store
```
