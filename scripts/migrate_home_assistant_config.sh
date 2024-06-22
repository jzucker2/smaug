#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=7
ORIGINAL_GLADOS_PI_IP=10.0.1.131

HOME_ASSISTANT_CONFIG_FILE="configuration.yaml"
HOME_ASSISTANT_BASE_DIR="${DATADIR}/home_assistant"
HOME_ASSISTANT_DIR="${HOME_ASSISTANT_BASE_DIR}/config"
HOME_ASSISTANT_CONFIG_PATH="${HOME_ASSISTANT_DIR}/${HOME_ASSISTANT_CONFIG_FILE}"

echo "Migrate home assistant config at DATADIR: ${DATADIR} with final HOME_ASSISTANT_BASE_DIR: ${HOME_ASSISTANT_BASE_DIR} in ${NUMBER_STEPS} steps using ORIGINAL_GLADOS_PI_IP: ${ORIGINAL_GLADOS_PI_IP} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing home assistant configs at HOME_ASSISTANT_BASE_DIR: ${HOME_ASSISTANT_BASE_DIR}"
sudo rm -rf ${HOME_ASSISTANT_BASE_DIR}

echo "[4/${NUMBER_STEPS}] put back home assistant configs"
sudo scp -r pi@${ORIGINAL_GLADOS_PI_IP}:${HOME_ASSISTANT_BASE_DIR} /${DATADIR}

echo "Read out config at HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH}"
sudo cat ${HOME_ASSISTANT_CONFIG_PATH}
echo ""

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${ZIGBEE2MQTT_DIR}"
sudo chmod -R 777 "${HOME_ASSISTANT_BASE_DIR}"

echo "[6/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[7/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done migrating home assistant for this host at final HOME_ASSISTANT_BASE_DIR: ${HOME_ASSISTANT_BASE_DIR} in ${NUMBER_STEPS} steps using ORIGINAL_GLADOS_PI_IP: ${ORIGINAL_GLADOS_PI_IP} !!!"
