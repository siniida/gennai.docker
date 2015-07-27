#!/bin/sh

sed -i \
  -e "s/^# \(cluster\.mode\):.*/\1: \"distributed\"/g" \
  -e "s/^# \(cluster\.zookeeper\.servers\):.*/\1:\n  - \"zk:2181\"/g" \
  /opt/gungnir-client/conf/gungnir.yaml

cd /opt/gungnir-client/bin

./gungnir -u root -p gennai
