#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=4
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="eleven-backport"
#DEPLOY_BRANCH=$DEV_BRANCH

ZIGBEE2MQTT_CONFIG_FILE="configuration.yaml"
ZIGBEE2MQTT_DEVICES_FILE="devices.yaml"

ZIGBEE2MQTT_BASE_DIR="${DATADIR}/zigbee2mqtt"
ZIGBEE2MQTT_DIR="${ZIGBEE2MQTT_BASE_DIR}/config"
ZIGBEE2MQTT_CONFIG_PATH="${ZIGBEE2MQTT_DIR}/${ZIGBEE2MQTT_CONFIG_FILE}"
ZIGBEE2MQTT_DEVICES_PATH="${ZIGBEE2MQTT_DIR}/${ZIGBEE2MQTT_DEVICES_FILE}"

echo "Set up Zigbee2MQTT at DATADIR: ${DATADIR} with final ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

sudo mkdir -p "${ZIGBEE2MQTT_DIR}"
sudo cp "zigbee2mqtt/${ZIGBEE2MQTT_CONFIG_FILE}" ${ZIGBEE2MQTT_CONFIG_PATH}
sudo cp "zigbee2mqtt/${ZIGBEE2MQTT_DEVICES_FILE}" ${ZIGBEE2MQTT_DEVICES_PATH}

echo "Read out config at ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH}"
sudo cat ${ZIGBEE2MQTT_CONFIG_PATH}
echo ""
echo "Read out config at ZIGBEE2MQTT_DEVICES_PATH: ${ZIGBEE2MQTT_DEVICES_PATH}"
sudo cat ${ZIGBEE2MQTT_DEVICES_PATH}

echo "[3/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${ZIGBEE2MQTT_DIR}"
sudo chmod -R 777 "${ZIGBEE2MQTT_BASE_DIR}"

echo "Done setting up ZigBee2MQTT at final ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH} for this host in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
