# smaug

Simple home automation template.

Fill out with some details.

To find your ethernet port:

```
ssh pi@smaug.local

ifconfig -a

...
# This is your ethernet MAC address
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.104  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fdd0:63d:7f0:9841:803f:c97b:62dc:51a1  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::c546:17cc:71f2:6b0d  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:da:d9:fd  txqueuelen 1000  (Ethernet)
        RX packets 159854397  bytes 21035329577 (19.5 GiB)
        RX errors 0  dropped 10328522  overruns 0  frame 0
        TX packets 106616914  bytes 142169637766 (132.4 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 106
...
# This is your wifi MAC address
wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.1.103  netmask 255.255.255.0  broadcast 10.0.1.255
        inet6 fe80::74ce:8281:938f:a37f  prefixlen 64  scopeid 0x20<link>
        ether d8:3a:dd:da:d9:fe  txqueuelen 1000  (Ethernet)
        RX packets 13075475  bytes 1929374840 (1.7 GiB)
        RX errors 0  dropped 5024910  overruns 0  frame 0
        TX packets 143792  bytes 14463907 (13.7 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
...
```

Need to create a file at `/etc/environment` containing the followinfg for health checks:

```
# The SMAUG_DHCP_IP should be whatever your ethernet port is
SMAUG_DHCP_IP=10.0.1.203
ZIGBEE_USB_DONGLE_PORT=/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_fcdb20559e9ced11a9aa77faa7669f5d-if00-port0
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
