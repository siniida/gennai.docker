#!/bin/sh

docker build -t siniida/zookeeper zookeeper
docker build -t siniida/kafka kafka
docker build -t siniida/storm-nimbus storm-nimbus
docker build -t siniida/storm-supervisor storm-supervisor
docker build -t siniida/gungnir-server gungnir-server
docker build -t siniida/tuple-store-server tuple-store-server
docker build -t siniida/gungnir-client gungnir-client
