#!/bin/sh

NUMBER_STEPS=1

echo "Configure git in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] configure git globals"
git config --global user.name "Jordan Zucker"
git config --global user.email "jordan.zucker@gmail.com"
# also helper store
git config --global credential.helper store

echo "Done configuring git in ${NUMBER_STEPS} steps!!!"
