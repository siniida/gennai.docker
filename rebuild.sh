#!/bin/sh

docker build -t siniida/zookeeper zookeeper
docker build -t siniida/kafka kafka
docker build -t siniida/storm storm
docker build -t siniida/gungnir-server gungnir-server
docker build -t siniida/gungnir-client gungnir-client
