#!/bin/sh

SCRIPTS_DIR=scripts
PI_SCRIPTS_DIR=${SCRIPTS_DIR}/pi

STEPS=2
echo "Install smaug in ${STEPS} steps!"

echo "[1/${STEPS}] check git status"
git status

echo "[2/${STEPS}] install docker"
sh ${PI_SCRIPTS_DIR}/docker_install.sh

echo "Done installing Smaug with all ${STEPS} steps!!!"
echo "Don't forget about ventura monitoring!"
echo "Still need to log in to docker, and bring up containers ..."

echo "Finish with a good 'ol reboot"
sudo reboot
