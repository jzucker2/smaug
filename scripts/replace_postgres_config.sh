#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=6

POSTGRES_CONFIG_FILE="data"

POSTGRES_BASE_DIR="${DATADIR}/postgres"
POSTGRES_DIR="${POSTGRES_BASE_DIR}/config"
POSTGRES_CONFIG_PATH="${POSTGRES_DIR}/${POSTGRES_CONFIG_FILE}"

echo "Replace Postgres config at DATADIR: ${DATADIR} with final POSTGRES_CONFIG_PATH: ${POSTGRES_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing Postgres configs"
sudo rm -rf ${POSTGRES_CONFIG_PATH}

echo "[4/${NUMBER_STEPS}] put back Postgres configs"
sudo mkdir -p ${POSTGRES_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${POSTGRES_DIR}"
sudo chmod -R 777 "${POSTGRES_BASE_DIR}"

echo "[5/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[6/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring Postgres for this host at final POSTGRES_CONFIG_PATH: ${POSTGRES_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
