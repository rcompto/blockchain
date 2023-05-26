#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -ev

# don't rewrite paths for Windows Git Bash users
#export MSYS_NO_PATHCONV=1

sudo docker-compose -f docker-compose.yml down

sudo docker-compose -f docker-compose.yml up -d ca.foxconn.com.br orderer.foxconn.com.br couchdb peer0.org1.foxconn.com.br
sudo docker ps -a

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}

# Create the channel
sudo docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.foxconn.com.br/msp" peer0.org1.foxconn.com.br peer channel create -o orderer.foxconn.com.br:7050 -c foxconn -f /etc/hyperledger/configtx/channel.tx
# Join peer0.org1.foxconn.com.br to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.foxconn.com.br/msp" peer0.org1.foxconn.com.br peer channel join -b foxconn.block

#Creating CLI Container
sudo docker-compose -f docker-compose.yml up -d cli
