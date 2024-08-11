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

## ZigBee

I am interested in a few things.

### Hardware

* `SONOFF Zigbee 3.0 USB Dongle Plus Gateway`
  * https://www.amazon.com/gp/product/B09KXTCMSC/ref=ppx_yo_dt_b_search_asin_image?ie=UTF8&psc=1
  * $30.99
* USB Extension Cord
  * https://www.amazon.com/gp/product/B00P0ES0VC/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1

#### Installation

Check for the device:

```
ls /dev/serial/by-id/
```

You should see something like:

```
pi@raspberrypi:~/smaug $ ls /dev/serial/by-id/
usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_ec3eb69a8d9ded118264d1a5a7669f5d-if00-port0
```

Then fill in `.env` like so:

```yaml
...
ZIGBEE2MQTT_TAG=1.36.1
ZIGBEE2MQTT_EXTERNAL_PORT=8777
ZIGBEE_USB_DONGLE_PORT=/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_ec3eb69a8d9ded118264d1a5a7669f5d-if00-port0
...
```
