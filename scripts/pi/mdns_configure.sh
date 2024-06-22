#!/bin/sh

NUMBER_STEPS=3

NAME=$1

# https://stackoverflow.com/questions/82256/how-do-i-use-sudo-to-redirect-output-to-a-location-i-dont-have-permission-to-wr

STARTING_PATH="/etc"
HOSTS_PATH="${STARTING_PATH}/hosts"
HOSTNAME_PATH="${STARTING_PATH}/hostname"

echo "Set up mdns in ${NUMBER_STEPS} steps using NAME: ${NAME}"

echo "[1/${NUMBER_STEPS}] read out original configs"
echo "For hosts at HOSTS_PATH: ${HOSTS_PATH}"
sudo cat $HOSTS_PATH
echo "For hostname at HOSTNAME_PATH: ${HOSTNAME_PATH}"
sudo cat $HOSTNAME_PATH


echo "[2/${NUMBER_STEPS}] now replace hosts config at HOSTS_PATH: ${HOSTS_PATH}"
sudo echo "127.0.0.1	localhost
::1		localhost ip6-localhost ip6-loopback
ff02::1		ip6-allnodes
ff02::2		ip6-allrouters

127.0.1.1		${NAME}
" | sudo tee $HOSTS_PATH
echo "Now print out new hosts config at HOSTS_PATH: ${HOSTS_PATH}"
sudo cat $HOSTS_PATH

echo "[3/${NUMBER_STEPS}] now replace hostname config at HOSTNAME_PATH: ${HOSTNAME_PATH}"
sudo echo "${NAME}
" | sudo tee $HOSTNAME_PATH
echo "Now print out new hostname config at HOSTNAME_PATH: ${HOSTNAME_PATH}"
sudo cat $HOSTNAME_PATH

echo "Done configuring mDNS in ${NUMBER_STEPS} steps with NAME: ${NAME} !!!"

echo "Now, reboot!"
sudo reboot
