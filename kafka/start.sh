#!/bin/sh

sed -i \
  -e "s/^\(zookeeper.connect\)=.*$/\1=zk:2181/g" \
  -e "s/^#\(host\.name\)=.*/\1=`hostname -i`/g" \
  /opt/kafka/config/server.properties

cd /opt/kafka
su kafka -c "./bin/kafka-server-start.sh /opt/kafka/config/server.properties"
