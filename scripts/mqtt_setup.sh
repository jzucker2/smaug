#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=4
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="eleven-backport"
#DEPLOY_BRANCH=$DEV_BRANCH

MOSQUITTO_CONFIG_FILE="mosquitto.conf"
MOSQUITTO_PW_FILE="pwfile"

MOSQUITTO_BASE_DIR="${DATADIR}/mosquitto"
MOSQUITTO_DIR="${MOSQUITTO_BASE_DIR}/config"
MOSQUITTO_CONFIG_PATH="${MOSQUITTO_DIR}/${MOSQUITTO_CONFIG_FILE}"
MOSQUITTO_PW_PATH="${MOSQUITTO_DIR}/${MOSQUITTO_PW_FILE}"

echo "Set up MQTT at DATADIR: ${DATADIR} with final MOSQUITTO_CONFIG_PATH: ${MOSQUITTO_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

echo "[3/${NUMBER_STEPS}] set up mosquitto"
sudo mkdir -p "${MOSQUITTO_DIR}"
sudo cp "mosquitto/${MOSQUITTO_CONFIG_FILE}" ${MOSQUITTO_CONFIG_PATH}
sudo cp "mosquitto/${MOSQUITTO_PW_FILE}" ${MOSQUITTO_PW_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${MOSQUITTO_DIR}"
sudo chmod -R 777 "${MOSQUITTO_BASE_DIR}"

echo "Done setting up MQTT at final MOSQUITTO_CONFIG_PATH: ${MOSQUITTO_CONFIG_PATH} for this host in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
