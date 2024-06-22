#!/bin/sh

NUMBER_STEPS=5


echo "Update all containers in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] check git branch"
git status

echo "[2/${NUMBER_STEPS}] quick check current containers"
docker compose images
docker compose ps

echo "[3/${NUMBER_STEPS}] pull new images"
docker compose pull

echo "[4/${NUMBER_STEPS}] update any newly pulled containers"
docker compose up -d --remove-orphans

echo "[5/${NUMBER_STEPS}] lastly, check containers"
docker compose images
docker compose ps

echo "Done updating all containers in ${NUMBER_STEPS} steps!!!"
