#!/bin/sh

cd /tmp
curl -L -O https://s3-ap-northeast-1.amazonaws.com/gennai/binary/jdk-7u71-linux-x64.rpm >/dev/null 2>&1

rpm -ivh ./jdk-7u71-linux-x64.rpm >/dev/null 2>&1
ln -s /usr/java/default/bin/jps /usr/bin/jps

# environment
OUTPUT=/home/gennai/.bashrc
echo >> ${OUTPUT}
echo "export JAVA_HOME=/usr/java/default" >> ${OUTPUT}
echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> ${OUTPUT}

rm jdk-7u71-linux-x64.rpm
