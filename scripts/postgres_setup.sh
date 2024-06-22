#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=4

POSTGRES_CONFIG_FILE="data"

POSTGRES_BASE_DIR="${DATADIR}/postgres"
POSTGRES_DIR="${POSTGRES_BASE_DIR}/config"
POSTGRES_CONFIG_PATH="${POSTGRES_DIR}/${POSTGRES_CONFIG_FILE}"

echo "Set up Postgres at DATADIR: ${DATADIR} with final POSTGRES_CONFIG_PATH: ${POSTGRES_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

echo "[3/${NUMBER_STEPS}] set up Postgres"
sudo mkdir -p "${POSTGRES_DIR}"
sudo mkdir -p ${POSTGRES_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
#sudo chown 1000:1000 "${POSTGRES_DIR}"
sudo chmod -R 777 "${POSTGRES_BASE_DIR}"

echo "Done setting up Postgres at final POSTGRES_CONFIG_PATH: ${POSTGRES_CONFIG_PATH} for this host in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
