#!/bin/sh

NUMBER_STEPS=4


echo "Restart home-assistant container in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] quick check current containers"
docker compose images
docker compose ps

echo "[3/${NUMBER_STEPS}] pull new images"
docker compose restart home-assistant

echo "[4/${NUMBER_STEPS}] lastly, check containers"
docker compose images
docker compose ps

echo "Done updating all containers in ${NUMBER_STEPS} steps!!!"
