#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=2

PIHOLE_BASE_DIR="${DATADIR}/pihole"
PIHOLE_DIR="${PIHOLE_BASE_DIR}/config"

echo "Set up Pi-Hole at DATADIR: ${DATADIR} with final PIHOLE_CONFIG_PATH: ${PIHOLE_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

sudo mkdir -p "${PIHOLE_DIR}"

echo "[3/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${PIHOLE_DIR}"
sudo chmod -R 777 "${PIHOLE_BASE_DIR}"

echo "Done setting up Pi-Hole at final PIHOLE_CONFIG_PATH: ${PIHOLE_CONFIG_PATH} for this host in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
