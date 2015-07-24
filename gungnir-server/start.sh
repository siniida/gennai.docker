#!/bin/bash

sed -i \
  -e "s/^# \(cluster\.mode\):.*/\1: \"distributed\"/g" \
  -e "s/^# \(cluster\.zookeeper\.servers\):.*/\1:\n  \- \"zk:2181\"/g" \
  -e "s/^# \(storm\.cluster\.mode\):.*/\1: \"distributed\"/g" \
  -e "s/^# \(storm\.nimbus\.host\):.*/\1: \"nimbus\"/g" \
  -e "s/^# \(metastore\.mongodb\.servers\):.*/\1:\n  \- \"mongo:27017\"/g" \
  -e "s/^# \(mongo\.fetch\.servers\):.*/\1:\n  \- \"mongo:27017\"/g" \
  -e "s/^# \(mongo\.persist\.servers\):.*/\1:\n  \- \"mongo:27017\"/g" \
  -e "s/^# \(kafka\.brokers\):.*/\1:\n  \- \"kafka:9092\"/g" \
  -e "s/^# \(kafka\.zookeeper\.servers\):.*/\1:\n  \- \"zk:2181\"/g" \
  -e "s/^# \(kafka\.emit\.brokers\):.*/\1:\n  \- \"kafka:9092\"/g" \
  /opt/gungnir-server/conf/gungnir.yaml

echo "===== gungnir.yaml (gungnir-server) ====="
cat /opt/gungnir-server/conf/gungnir.yaml
echo "===== gungnir.yaml (gungnir-server) ====="

sed -i -e "s/WARN/INFO/" /opt/gungnir-server/conf/logback.xml

cd /opt/gungnir-server
su gennai -c "./bin/gungnir-server.sh start"
su gennai -c "touch /opt/gungnir-server/logs/gungnir.log"
tail -f /opt/gungnir-server/logs/gungnir.log

# EOF
