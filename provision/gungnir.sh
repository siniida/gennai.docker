#!/bin/sh

cd /tmp
curl -L -O https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-server-0.0.1-20150612.tar.gz >/dev/null 2>&1
curl -L -O https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-client-0.0.1-20150612.tar.gz >/dev/null 2>&1

tar zxf gungnir-server-0.0.1-20150612.tar.gz -C /opt
tar zxf gungnir-client-0.0.1-20150612.tar.gz -C /opt

ln -s /opt/gungnir-server-0.0.1 /opt/gungnir-server
ln -s /opt/gungnir-client-0.0.1 /opt/gungnir-client

chown -R gennai:gennai /opt/gungnir-server-0.0.1
chown -R gennai:gennai /opt/gungnir-client-0.0.1

sed -i -e 's/^# \(storm.cluster.mode: .*\)$/\1/g' /opt/gungnir-server/conf/gungnir.yaml

OUTPUT=/home/gennai/.bashrc
echo "" >> ${OUTPUT}
echo "export GUNGNIR_HOME=/opt/gungnir-client" >> ${OUTPUT}
echo "export PATH=\${GUNGNIR_HOME}/bin:\${PATH}" >> ${OUTPUT}
