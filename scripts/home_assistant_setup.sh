#!/bin/sh

DATADIR="/dockerData"


NUMBER_STEPS=4
DEPLOY_BRANCH="master"
# uncomment one of the below to use a dev branch
#DEV_BRANCH="eleven-backport"
#DEPLOY_BRANCH=$DEV_BRANCH

HOME_ASSISTANT_CONFIG_FILE="configuration.yaml"

HOME_ASSISTANT_DIR="${DATADIR}/home_assistant/config"
HOME_ASSISTANT_CONFIG_PATH="${HOME_ASSISTANT_DIR}/${HOME_ASSISTANT_CONFIG_FILE}"


echo "Set up home assistant at DATADIR: ${DATADIR} with final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] create docker data directory at DATADIR: ${DATADIR}"
sudo mkdir -p "${DATADIR}"

echo "[3/${NUMBER_STEPS}] create app directories at final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH}"
sudo mkdir -p "${HOME_ASSISTANT_DIR}"
sudo cp "home_assistant/${HOME_ASSISTANT_CONFIG_FILE}" ${HOME_ASSISTANT_CONFIG_PATH}

echo "[4/${NUMBER_STEPS}] lastly set permissions at final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH}"
sudo chown 1000:1000 "${HOME_ASSISTANT_DIR}"

echo "Done setting up home-assistant for this host at final HOME_ASSISTANT_CONFIG_PATH: ${HOME_ASSISTANT_CONFIG_PATH} in ${NUMBER_STEPS} steps using DEPLOY_BRANCH: ${DEPLOY_BRANCH} !!!"
#echo "Now reboot!"
#sudo reboot
