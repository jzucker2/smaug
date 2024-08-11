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
sudo dmesg
```

You should see something like:

```
[138287.682162] hwmon hwmon2: Undervoltage detected!
[138299.778338] hwmon hwmon2: Voltage normalised
[138305.290299] usb 1-1.1: new full-speed USB device number 3 using xhci_hcd
[138305.399950] usb 1-1.1: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
[138305.399992] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[138305.400010] usb 1-1.1: Product: Sonoff Zigbee 3.0 USB Dongle Plus
[138305.400026] usb 1-1.1: Manufacturer: ITead
[138305.400039] usb 1-1.1: SerialNumber: 4c014405c5e7ec118ee67860e89bdf6f
[138305.526716] usbcore: registered new interface driver usbserial_generic
[138305.526870] usbserial: USB Serial support registered for generic
[138305.540365] usbcore: registered new interface driver cp210x
[138305.540534] usbserial: USB Serial support registered for cp210x
[138305.540731] cp210x 1-1.1:1.0: cp210x converter detected
[138305.553310] usb 1-1.1: cp210x converter now attached to ttyUSB0
[138305.826923] hwmon hwmon2: Undervoltage detected!
[138311.874509] hwmon hwmon2: Voltage normalised
```

Double check device and permissions:

```
pi@glados:~/glados $ ls -l /dev/ttyUSB0
crw-rw---- 1 root dialout 188, 0 May 28 13:43 /dev/ttyUSB0
```
