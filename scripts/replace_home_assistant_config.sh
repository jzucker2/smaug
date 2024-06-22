#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=7
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="initial-project"
#DEPLOY_BRANCH=$DEV_BRANCH

HOME_ASSISTANT_CONFIG_FILE="configuration.yaml"

HOME_ASSISTANT_DIR="${DATADIR}/home_assistant/config"
HOME_ASSISTANT_CONFIG_PATH="${HOME_ASSISTANT_DIR}/${HOME_ASSISTANT_CONFIG_FILE}"

echo "Replace home assistant config at DATADIR: ${DATADIR} with final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] start by bringing down containers"
docker compose down

echo "[3/${NUMBER_STEPS}] remove existing home assistant configs"
sudo rm ${HOME_ASSISTANT_CONFIG_PATH}

echo "[4/${NUMBER_STEPS}] put back home assistant configs"
sudo cp "home_assistant/${HOME_ASSISTANT_CONFIG_FILE}" ${HOME_ASSISTANT_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] now ensure proper permissions on newly replaced files"
sudo chown 1000:1000 "${HOME_ASSISTANT_DIR}"

echo "[6/${NUMBER_STEPS}] bring back up containers"
docker compose up -d --remove-orphans

echo "[7/${NUMBER_STEPS}] lastly, check the containers"
docker compose ps

echo "Done reconfiguring home assistant for this host at final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
