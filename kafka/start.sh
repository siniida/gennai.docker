#!/bin/sh

sed -i \
  -e "s/^\(zookeeper.connect\)=.*$/\1=$ZK_PORT_2181_TCP_ADDR:2181/g" \
  -e "s/^#\(host\.name\)=.*/\1=`hostname -i`/g" \
  /opt/kafka/config/server.properties

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &
KAFKA_SERVER_PID=$!

wait ${KAFKA_SERVER_PID}
