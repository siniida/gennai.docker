#!/bin/sh

CONFIG=/opt/storm/conf/storm.yaml

### zookeeper
if [ -n "${ZOOKEEPERS}" ]
then
	echo "ZooKeeper: ${ZOOKEEPERS}"
	for i in ${ZOOKEEPERS//,/ }
	do
		ZK_STR="${ZK_STR}\n    - \"${i%:*}\""
	done
	sed -i -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:${ZK_STR}/g" ${CONFIG}
elif [ `env | grep -c 2181_TCP_ADDR` -gt 0 ]
then
	# get zookeeper address from env.
	for i in `env | grep 2181_TCP_ADDR | cut -d = -f 2`
	do
		ZK_STR="${ZK_STR},${i}:2181"
		echo "ZooKeeper: ${ZK_STR:1}"
		sed -i -e "s/.*\(storm\.zookeeper\.servers\):.*/\1:${ZK_STR:1}/g" ${CONFIG}
	done
fi

### nimbus host
if [ -n "${NIMBUS}" ]
then
	echo "Nimbus: ${NIMBUS}"
	sed -i -e "s/.*\(nimbus\.host\):.*/\1: \"${NIMBUS}\"/g" ${CONFIG}
else
	echo "Nimbus: this container (`hostname -i`)."
	sed -i -e "s/.*\(nimbus\.host\):.*/\1: \"`hostname -i`\"/g" ${CONFIG}
fi

### local.hostname
echo "storm.local.hostname: `hostname -i`" >> ${CONFIG}

### role
if [ -n "${ROLE}" ]
then
	case ${ROLE} in
		nimbus)
			exec /opt/storm/bin/storm nimbus
			;;
		supervisor)
			exec /opt/storm/bin/storm supervisor
			;;
		ui)
			exec /opt/storm/bin/storm ui
			;;
	esac
fi

exec $@

# EOF
