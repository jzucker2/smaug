#!/bin/sh

NUMBER_STEPS=2

echo "Install bluetooth deps in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] install bluetooth dependencies"
sudo apt-get -y install pulseaudio pulseaudio-module-bluetooth bluez-tools

echo "[2/${NUMBER_STEPS}] now set bluetooth user permissions"
sudo usermod -aG bluetooth ${USER}

echo "Done installing bluetooth deps in ${NUMBER_STEPS} steps!!!"

echo "Now, reboot!"
sudo reboot
