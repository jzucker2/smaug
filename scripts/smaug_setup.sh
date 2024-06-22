#!/bin/sh

SCRIPTS_DIR=scripts


NUMBER_STEPS=6


echo "Set up all smaug apps with SCRIPTS_DIR: ${SCRIPTS_DIR} in ${NUMBER_STEPS} steps !"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${STEPS}] set up home assistant"
sh ${SCRIPTS_DIR}/home_assistant_setup.sh

echo "[3/${STEPS}] set up mqtt mosquitto"
sh ${SCRIPTS_DIR}/mqtt_setup.sh

echo "[4/${STEPS}] set up node red"
sh ${SCRIPTS_DIR}/node_red_setup.sh

echo "[5/${STEPS}] set up postgres"
sh ${SCRIPTS_DIR}/postgres_setup.sh

echo "[6/${STEPS}] set up zigbee2mqtt"
sh ${SCRIPTS_DIR}/zigbee2mqtt_setup.sh

echo "Done setting up all smaug for this host at final SCRIPTS_DIR: ${SCRIPTS_DIR} in ${NUMBER_STEPS} steps !!!"
#echo "Now reboot!"
#sudo reboot
