#!/bin/sh

cd /tmp
curl -L -O http://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz >/dev/null 2>&1
tar zxf zookeeper-3.4.6.tar.gz -C /opt
ln -s /opt/zookeeper-3.4.6 /opt/zookeeper
chown -R gennai:gennai /opt/zookeeper-3.4.6
cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg

# environment
OUTPUT=/home/gennai/.bashrc
echo "" >> ${OUTPUT}
echo "export ZOOKEEPER_HOME=/opt/zookeeper" >> ${OUTPUT}
echo "export PATH=\${ZOOKEEPER_HOME}/bin:\${PATH}" >> ${OUTPUT}
echo "export ZOO_LOG_DIR=/opt/zookeeper" >> ${OUTPUT}
