#!/bin/bash

apt-get install git
apt-get install curl
apt-get install docker-compose
systemctl enable docker
usermod -a -G docker ubuntu
wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzvf go1.20.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
cd /opt/
git clone https://github.com/rcompto/blockchain.git
chmod +x blockchain/basic-network/bin/*
chmod +x blockchain/basic-network/*.sh
