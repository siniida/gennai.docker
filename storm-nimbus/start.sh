#!/bin/sh

sed -i \
  -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:\n    - \"zk\"/g" \
  -e "s/.*\(nimbus\.host\):.*/\1: \"`hostname -i`\"/g" \
  /opt/storm/conf/storm.yaml
echo "storm.local.hostname: `hostname -i`" >> /opt/storm/conf/storm.yaml

echo "==== storm.yaml (nimbus) ====="
cat /opt/storm/conf/storm.yaml
echo "==== storm.yaml (nimbus) ====="

cd /opt/storm
su storm -c "./bin/storm nimbus &"
su storm -c "touch /opt/storm/logs/nimbus.log"
tail -f /opt/storm/logs/nimbus.log

# EOF
