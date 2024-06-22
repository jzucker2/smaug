#!/bin/sh

NUMBER_STEPS=5

echo "Install docker in ${NUMBER_STEPS} steps!"

echo "[1/${NUMBER_STEPS}] set up docker apt repository"
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "[2/${NUMBER_STEPS}] now install docker"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[3/${NUMBER_STEPS}] now set docker user permissions"
sudo usermod -aG docker ${USER}

echo "[4/${NUMBER_STEPS}] lastly, make docker launch on boot"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

echo "Done installing docker in ${NUMBER_STEPS} steps!!!"

#echo "Now, reboot!"
#sudo reboot
