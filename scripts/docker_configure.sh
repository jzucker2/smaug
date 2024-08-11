#!/bin/sh

NUMBER_STEPS=8

DOCKER_CONFIG_PATH="docker/daemon.json"
SYS_DOCKER_CONFIG_PATH="/etc/${DOCKER_CONFIG_PATH}"

DOCKER_SERVICE_CONFIG_FILENAME="docker.service"
LOCAL_DOCKER_SERVICE_CONFIG_PATH="docker/${DOCKER_SERVICE_CONFIG_FILENAME}"
DOCKER_SERVICE_CONFIG_DIR="/lib/systemd/system"
DOCKER_SERVICE_OLD_CONFIG_PATH="${DOCKER_SERVICE_CONFIG_DIR}/old.${DOCKER_SERVICE_CONFIG_FILENAME}"
DOCKER_SERVICE_CONFIG_PATH="${DOCKER_SERVICE_CONFIG_DIR}/${DOCKER_SERVICE_CONFIG_FILENAME}"

echo "Configure the docker daemon config at DOCKER_CONFIG_PATH: ${DOCKER_CONFIG_PATH} in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] if any containers are running, bring them down"
docker compose down --remove-orphans

echo "[3/${NUMBER_STEPS}] optionally prep by clearing out the existing config at SYS_DOCKER_CONFIG_PATH: ${SYS_DOCKER_CONFIG_PATH}"
sudo rm ${SYS_DOCKER_CONFIG_PATH}

echo "[4/${NUMBER_STEPS}] set the new docker daemon config from DOCKER_CONFIG_PATH: ${DOCKER_CONFIG_PATH} to SYS_DOCKER_CONFIG_PATH: ${SYS_DOCKER_CONFIG_PATH}"
sudo cp ${DOCKER_CONFIG_PATH} ${SYS_DOCKER_CONFIG_PATH}

echo "[5/${NUMBER_STEPS}] replace the docker.service config from LOCAL_DOCKER_SERVICE_CONFIG_PATH: ${LOCAL_DOCKER_SERVICE_CONFIG_PATH} to DOCKER_SERVICE_CONFIG_PATH: ${DOCKER_SERVICE_CONFIG_PATH}"
sudo mv ${DOCKER_SERVICE_CONFIG_PATH} ${DOCKER_SERVICE_OLD_CONFIG_PATH}
sudo cp ${LOCAL_DOCKER_SERVICE_CONFIG_PATH} ${DOCKER_SERVICE_CONFIG_PATH}
sudo chmod +rwx ${DOCKER_SERVICE_CONFIG_PATH}
sudo cat ${DOCKER_SERVICE_CONFIG_PATH}

echo "Done configuring the docker daemon at SYS_DOCKER_CONFIG_PATH: ${SYS_DOCKER_CONFIG_PATH} in ${NUMBER_STEPS} steps!!!"

echo "print configuration of SYS_DOCKER_CONFIG_PATH: ${SYS_DOCKER_CONFIG_PATH} below ---->"
sudo cat ${SYS_DOCKER_CONFIG_PATH}

#echo "Now reboot to apply changes the easy way"
#sudo reboot

echo "[6/${NUMBER_STEPS}] First reload the systemd units because I changed them (the bad way)"
sudo systemctl daemon-reload

echo "[7/${NUMBER_STEPS}] Now restart docker to apply the daemon changes"
sudo systemctl restart docker

echo "!!! Remember !!! You still need to restart the actual containers! Rules only apply to _new_ containers!"

echo "[8/${NUMBER_STEPS}] if any containers are running, bring them back up"
docker compose up -d --remove-orphans
