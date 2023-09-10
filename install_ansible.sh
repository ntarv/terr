#!/bin/bash
sudo /bin/bash
echo "sysops ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sysops
apt update
apt upgrade -y
apt install -y software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt update
apt install -y ansible
