#!/bin/sh

sed -i \
  -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:\n    - \"zk\"/g" \
  -e "s/.*\(nimbus\.host\):.*/\1: \"nimbus\"/g" \
  /opt/storm/conf/storm.yaml
echo "storm.local.hostname: `hostname -i`" >> /opt/storm/conf/storm.yaml

echo "===== storm.yaml (supervisor) ====="
cat /opt/storm/conf/storm.yaml
echo "===== storm.yaml (supervisor) ====="

cd /opt/storm
su storm -c "./bin/storm supervisor &"
su storm -c "touch /opt/storm/logs/supervisor.log /opt/storm/logs/worker-670{0,1,2,3}.log"
tail -f /opt/storm/logs/supervisor.log /opt/storm/logs/worker-*.log

# EOF
