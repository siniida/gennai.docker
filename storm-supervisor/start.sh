#!/bin/sh

sed -i \
  -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:\n    - \"${ZK_PORT_2181_TCP_ADDR}\"/g" \
  -e "s/.*\(nimbus\.host\):.*/\1: \"${NIMBUS_PORT_6627_TCP_ADDR}\"/g" \
  /opt/storm/conf/storm.yaml
echo "storm.local.hostname: `hostname -i`" >> /opt/storm/conf/storm.yaml

echo "===== storm.yaml (supervisor) ====="
cat /opt/storm/conf/storm.yaml
echo "===== storm.yaml (supervisor) ====="

/opt/storm/bin/storm supervisor
SUPERVISOR_PID=$!
wait ${SUPERVISOR_PID}

# EOF
