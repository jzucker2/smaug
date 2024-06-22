#!/bin/sh

MDNS_NAME="gerlack"

SCRIPTS_DIR=scripts
PI_SCRIPTS_DIR=${SCRIPTS_DIR}/pi

STEPS=2
echo "Set up gerlack mDNS in ${STEPS} steps!"

echo "[1/${STEPS}] update git branch"
git fetch --all
git status
git pull

echo "[2/${STEPS}] set up mDNS with MDNS_NAME: ${MDNS_NAME} (this invokes a reboot)"
sh ${PI_SCRIPTS_DIR}/mdns_configure.sh ${MDNS_NAME}
