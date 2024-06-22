#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=6
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="initial-project"
#DEPLOY_BRANCH=$DEV_BRANCH

NODE_RED_CONFIG_FILE="settings.js"

NODE_RED_BASE_DIR="${DATADIR}/node_red"
NODE_RED_DIR="${NODE_RED_BASE_DIR}/config"
NODE_RED_CONFIG_PATH="${NODE_RED_DIR}/${NODE_RED_CONFIG_FILE}"

echo "Replace Node-RED config at DATADIR: ${DATADIR} with final NODE_RED_CONFIG_PATH: ${NODE_RED_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing Node-RED configs"
sudo rm ${NODE_RED_CONFIG_PATH}

echo "[4/${NUMBER_STEPS}] put back Node-RED configs"
sudo cp "node_red/${NODE_RED_CONFIG_FILE}" ${NODE_RED_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${NODE_RED_DIR}"
sudo chmod -R 777 "${NODE_RED_BASE_DIR}"

echo "[5/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[6/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring Node-RED for this host at final NODE_RED_CONFIG_PATH: ${NODE_RED_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
