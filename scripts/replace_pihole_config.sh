#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=6


PIHOLE_BASE_DIR="${DATADIR}/pihole"
PIHOLE_DIR="${PIHOLE_BASE_DIR}/config"
PIHOLE_CONFIG_PATH="${PIHOLE_DIR}/${PIHOLE_CONFIG_FILE}"
PIHOLE_DEVICES_PATH="${PIHOLE_DIR}/${PIHOLE_DEVICES_FILE}"

echo "Replace Pi-Hole config at DATADIR: ${DATADIR} with final PIHOLE_CONFIG_PATH: ${PIHOLE_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down --remove-orphans

echo "[3/${NUMBER_STEPS}] remove existing pihole directores at PIHOLE_BASE_DIR: ${PIHOLE_BASE_DIR}"
sudo rm -rf ${PIHOLE_BASE_DIR}

echo "[4/${NUMBER_STEPS}] recreate pihole config directories"
sudo mkdir -p ${PIHOLE_BASE_DIR}
sudo mkdir -p ${PIHOLE_DIR}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${PIHOLE_DIR}"
sudo chmod -R 777 "${PIHOLE_BASE_DIR}"

echo "[5/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[6/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring Pi-Hole for this host at final PIHOLE_CONFIG_PATH: ${PIHOLE_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
