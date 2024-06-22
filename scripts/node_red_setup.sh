#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=4
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="eleven-backport"
#DEPLOY_BRANCH=$DEV_BRANCH

NODE_RED_CONFIG_FILE="settings.js"

NODE_RED_BASE_DIR="${DATADIR}/node_red"
NODE_RED_DIR="${NODE_RED_BASE_DIR}/config"
NODE_RED_CONFIG_PATH="${NODE_RED_DIR}/${NODE_RED_CONFIG_FILE}"

echo "Set up Node-RED at DATADIR: ${DATADIR} with final NODE_RED_CONFIG_PATH: ${NODE_RED_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

echo "[3/${NUMBER_STEPS}] set up Node-RED"
sudo mkdir -p "${NODE_RED_DIR}"
sudo cp "node_red/${NODE_RED_CONFIG_FILE}" ${NODE_RED_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${NODE_RED_DIR}"
sudo chmod -R 777 "${NODE_RED_BASE_DIR}"

echo "Done setting up Node-RED at final NODE_RED_CONFIG_PATH: ${NODE_RED_CONFIG_PATH} for this host in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
