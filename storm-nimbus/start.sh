#!/bin/sh

sed -i \
  -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:\n    - \"${ZK_PORT_2181_TCP_ADDR}\"/g" \
  -e "s/.*\(nimbus\.host\):.*/\1: \"`hostname -i`\"/g" \
  /opt/storm/conf/storm.yaml
echo "storm.local.hostname: `hostname -i`" >> /opt/storm/conf/storm.yaml

echo "==== storm.yaml (nimbus) ====="
cat /opt/storm/conf/storm.yaml
echo "==== storm.yaml (nimbus) ====="

/opt/storm/bin/storm nimbus
NIMBUS_PID=$!
wait ${NIMBUS_PID}

# EOF
