# smaug

Simple home automation template.

```
git clone https://github.com/jzucker2/smaug
```

Fill out with some details.

To find your ethernet port:

```
ssh pi@smaug.local

ifconfig -a

...
# This is your ethernet MAC address
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.111  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fdd0:63d:7f0:9841:b604:9160:88a9:f1c7  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::ee3a:e170:88da:bfcd  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:28:50:aa  txqueuelen 1000  (Ethernet)
        RX packets 21416  bytes 7713281 (7.3 MiB)
        RX errors 0  dropped 96  overruns 0  frame 0
        TX packets 18523  bytes 2773762 (2.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
...
# This is your wifi MAC address
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.112  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fdd0:63d:7f0:9841:9c07:f8ee:e96a:372e  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::7c6c:ad82:8d30:53fc  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:28:50:ab  txqueuelen 1000  (Ethernet)
        RX packets 7083  bytes 1105988 (1.0 MiB)
        RX errors 0  dropped 1133  overruns 0  frame 0
        TX packets 116  bytes 26942 (26.3 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
...
```

Need to create a file at `/etc/environment` containing the followinfg for health checks:

```
# The SMAUG_DHCP_IP should be whatever your ethernet port is
SMAUG_DHCP_IP=10.0.1.111
ZIGBEE_USB_DONGLE_PORT=/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_fcdb20559e9ced11a9aa77faa7669f5d-if00-port0
DOCKER_LOCALHOST="host.docker.internal"
# customize below for your db
POSTGRES_USER=posty
POSTGRES_PASSWORD=postypass
PIHOLE_PASSWORD=pipassword
PIHOLE_API_TOKEN=pisecretaccesstoken
HOME_ASSISTANT_EXTERNAL_PORT=8123
POSTGRES_DEFAULT_DB=home_assistant
MOSQUITTO_EXTERNAL_PORT=1883
MOSQUITTO_EXPORTER_EXTERNAL_PORT=9234
MOSQUITTO_USER=hass
MOSQUITTO_PASSWORD=hasspass
ZIGBEE2MQTT_EXTERNAL_PORT=8777
NODE_RED_EXTERNAL_PORT=1880
NODE_RED_HEALTHCHECK_PORT=1881
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

Then fill in `/etc/environment` and `sudo reboot` to restart and apply

### Fan

To set the fan:

```
sudo raspi-config
```

Then activate fan and reboot.
