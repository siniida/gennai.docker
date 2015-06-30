#!/bin/sh

cd /tmp
curl -L -O https://archive.apache.org/dist/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz >/dev/null 2>&1
tar zxf kafka_2.10-0.8.2.1.tgz -C /opt
ln -s /opt/kafka_2.10-0.8.2.1 /opt/kafka
chown -R gennai:gennai /opt/kafka_2.10-0.8.2.1

# environment
OUTPUT=/home/gennai/.bashrc
echo "" >> ${OUTPUT}
echo "export KAFKA_HOME=/opt/kafka" >> ${OUTPUT}
echo "export PATH=\${KAFKA_HOME}/bin:\${PATH}" >> ${OUTPUT}
