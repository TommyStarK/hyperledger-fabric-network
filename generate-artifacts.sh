#!/usr/bin/env bash

set -e
rm -rf channel-artifacts
rm -rf crypto-config

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; cryptogen generate --config=./crypto-config.yaml"

mkdir channel-artifacts

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile OrdererGenesis -channelID orderer-system-channel -outputBlock ./channel-artifacts/genesis.block"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile Channel12 -outputCreateChannelTx ./channel-artifacts/channel12.tx -channelID channel12"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile ChannelAll -outputCreateChannelTx ./channel-artifacts/channelall.tx -channelID channelall"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile Channel12 -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_channel12.tx -channelID channel12 -asOrg Org1MSP"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile Channel12 -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_channel12.tx -channelID channel12 -asOrg Org2MSP"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile ChannelAll -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_channelall.tx -channelID channelall -asOrg Org1MSP"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile ChannelAll -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_channelall.tx -channelID channelall -asOrg Org2MSP"

docker run -it --rm --mount type=bind,src=`pwd`,dst=/crypto hyperledger/fabric-tools:2.3.0 bash -c \
"cd /crypto ; export FABRIC_CFG_PATH=/crypto ; configtxgen -profile ChannelAll -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors_channelall.tx -channelID channelall -asOrg Org3MSP"
