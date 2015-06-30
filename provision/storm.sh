#!/bin/sh

cd /tmp
curl -L -O https://archive.apache.org/dist/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz > /dev/null 2>&1
tar zxf apache-storm-0.9.4.tar.gz -C /opt
ln -s /opt/apache-storm-0.9.4 /opt/storm
mkdir /opt/storm/storm-local/
chown -R gennai:gennai /opt/apache-storm-0.9.4

sed -i -e 's/^# \(storm.zookeeper.servers:\)$/\1\n    - "localhost"/g' /opt/storm/conf/storm.yaml
sed -i -e 's/^# \(nimbus.host: \)"nimbus"$/\1 "localhost"/g' /opt/storm/conf/storm.yaml
echo 'storm.local.dir: "/opt/storm/storm-local"' >> /opt/storm/conf/storm.yaml
