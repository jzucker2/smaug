#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=6
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="initial-project"
#DEPLOY_BRANCH=$DEV_BRANCH

ZIGBEE2MQTT_CONFIG_FILE="configuration.yaml"
ZIGBEE2MQTT_DEVICES_FILE="devices.yaml"

ZIGBEE2MQTT_BASE_DIR="${DATADIR}/zigbee2mqtt"
ZIGBEE2MQTT_DIR="${ZIGBEE2MQTT_BASE_DIR}/config"
ZIGBEE2MQTT_CONFIG_PATH="${ZIGBEE2MQTT_DIR}/${ZIGBEE2MQTT_CONFIG_FILE}"
ZIGBEE2MQTT_DEVICES_PATH="${ZIGBEE2MQTT_DIR}/${ZIGBEE2MQTT_DEVICES_FILE}"

echo "Replace zigbee2mqtt config at DATADIR: ${DATADIR} with final ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing zigbee2mqtt configs"
sudo rm ${ZIGBEE2MQTT_CONFIG_PATH}
sudo rm ${ZIGBEE2MQTT_DEVICES_PATH}

echo "[4/${NUMBER_STEPS}] put back zigbee2mqtt configs"
sudo cp "zigbee2mqtt/${ZIGBEE2MQTT_CONFIG_FILE}" ${ZIGBEE2MQTT_CONFIG_PATH}
sudo cp "zigbee2mqtt/${ZIGBEE2MQTT_DEVICES_FILE}" ${ZIGBEE2MQTT_DEVICES_PATH}

echo "Read out config at ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH}"
sudo cat ${ZIGBEE2MQTT_CONFIG_PATH}
echo ""
echo "Read out config at ZIGBEE2MQTT_DEVICES_PATH: ${ZIGBEE2MQTT_DEVICES_PATH}"
sudo cat ${ZIGBEE2MQTT_DEVICES_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${ZIGBEE2MQTT_DIR}"
sudo chmod -R 777 "${ZIGBEE2MQTT_BASE_DIR}"

echo "[5/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[6/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring zigbee2mqtt for this host at final ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
