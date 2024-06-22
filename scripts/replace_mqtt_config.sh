#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=6
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="initial-project"
#DEPLOY_BRANCH=$DEV_BRANCH

MOSQUITTO_CONFIG_FILE="mosquitto.conf"
MOSQUITTO_PW_FILE="pwfile"

MOSQUITTO_BASE_DIR="${DATADIR}/mosquitto"
MOSQUITTO_DIR="${MOSQUITTO_BASE_DIR}/config"
MOSQUITTO_CONFIG_PATH="${MOSQUITTO_DIR}/${MOSQUITTO_CONFIG_FILE}"
MOSQUITTO_PW_PATH="${MOSQUITTO_DIR}/${MOSQUITTO_PW_FILE}"

echo "Replace mosquitto config at DATADIR: ${DATADIR} with final MOSQUITTO_CONFIG_PATH: ${MOSQUITTO_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing mosquitto configs"
sudo rm ${MOSQUITTO_CONFIG_PATH}
sudo rm ${MOSQUITTO_PW_PATH}

echo "[4/${NUMBER_STEPS}] put back mosquitto configs"
sudo cp "mosquitto/${MOSQUITTO_CONFIG_FILE}" ${MOSQUITTO_CONFIG_PATH}
sudo cp "mosquitto/${MOSQUITTO_PW_FILE}" ${MOSQUITTO_PW_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${MOSQUITTO_DIR}"
sudo chmod -R 777 "${MOSQUITTO_BASE_DIR}"

echo "[5/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[6/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring mosquitto for this host at final MOSQUITTO_CONFIG_PATH: ${MOSQUITTO_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
