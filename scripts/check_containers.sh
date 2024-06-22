#!/bin/sh

STEPS=5
echo "Check all containers in ${STEPS} steps!"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${STEPS}] check current container images"
docker compose images

echo "[3/${STEPS}] check current container status"
docker compose ps

echo "[4/${STEPS}] (optionally) restart containers"
docker compose up -d --remove-orphans

echo "[5/${STEPS}] confirm containers"
docker compose ps

echo "Done with all ${STEPS} steps. Checked all containers!!!"
