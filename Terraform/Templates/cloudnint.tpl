#!/usr/bin/env bash
set -x
source /etc/lsb-release

sudo DEBIAN_FRONTEND="noninteractive" apt-get -y dist-upgrade

sudo apt-get update -y
sudo apt-get install python-pip software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

sudo pip install docker-py

sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y

sudo apt-get update

sudo apt-get install docker-ce -y

sudo adduser $USER docker

echo "Init script completed successfully" >> ~/initscript.txt

