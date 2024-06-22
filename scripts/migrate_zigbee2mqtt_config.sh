#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=7
ORIGINAL_GLADOS_PI_IP=10.0.1.131

ZIGBEE2MQTT_CONFIG_FILE="configuration.yaml"
ZIGBEE2MQTT_BASE_DIR="${DATADIR}/zigbee2mqtt"
ZIGBEE2MQTT_DIR="${ZIGBEE2MQTT_BASE_DIR}/config"
ZIGBEE2MQTT_CONFIG_PATH="${ZIGBEE2MQTT_DIR}/${ZIGBEE2MQTT_CONFIG_FILE}"

echo "Migrate zigbee2mqtt config at DATADIR: ${DATADIR} with final ZIGBEE2MQTT_BASE_DIR: ${ZIGBEE2MQTT_BASE_DIR} in ${NUMBER_STEPS} steps using ORIGINAL_GLADOS_PI_IP: ${ORIGINAL_GLADOS_PI_IP} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing zigbee2mqtt configs at ZIGBEE2MQTT_BASE_DIR: ${ZIGBEE2MQTT_BASE_DIR}"
sudo rm -rf ${ZIGBEE2MQTT_BASE_DIR}

echo "[4/${NUMBER_STEPS}] put back zigbee2mqtt configs"
sudo scp -r pi@${ORIGINAL_GLADOS_PI_IP}:${ZIGBEE2MQTT_BASE_DIR} /${DATADIR}

echo "Read out config at ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH}"
sudo cat ${ZIGBEE2MQTT_CONFIG_PATH}
echo ""

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${ZIGBEE2MQTT_DIR}"
sudo chmod -R 777 "${ZIGBEE2MQTT_BASE_DIR}"

echo "[6/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[7/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done migrating zigbee2mqtt for this host at final ZIGBEE2MQTT_CONFIG_PATH: ${ZIGBEE2MQTT_CONFIG_PATH} in ${NUMBER_STEPS} steps using ORIGINAL_GLADOS_PI_IP: ${ORIGINAL_GLADOS_PI_IP} !!!"
