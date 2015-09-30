#!/bin/sh

if [ -n "${ZOOKEEPER}" ]
then
	echo "ZooKeeper: ${ZOOKEEPER}"
	for i in ${ZOOKEEPER//,/ }
	do
		ZK_STR="${ZK_STR}\n  - \"${i}\""
	done
elif [ `env | grep -c 2181_TCP_ADDR` -gt 0 ]
then
	for i in `env | grep 2181_TCP_ADDR | cut -d = -f 2`
	do
		ZK_STR="${ZK_STR}\n  - \"${i}:2181\""
	done
else
	echo "[ERROR] not set ZooKeeper." >&2
	exit 1
fi

# change config
# * cluster.mode
# * cluster.zookeeper.servers
sed -i \
	-e "s/.*\(cluster\.mode\):.*/\1: \"distributed\"/g" \
	-e "s/.*\(cluster\.zookeeper\.servers\):.*/\1:${ZK_STR}/g" \
	/opt/gungnir-client/conf/gungnir.yaml

exec $@
