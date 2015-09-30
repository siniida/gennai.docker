#!/bin/sh

CONFIG=/opt/gungnir-server/conf/gungnir.yaml

function local_mode {
	echo "cluster.mode: local."
	su - gennai \
		/opt/gungnir-server/bin/gungnir-server.sh start \
		/opt/gungnir-server/conf/gungnir-standalone.yaml
}

function distributed_mode {
	echo "cluster.mode: distributed."

	### ROLE (gungnir-server/tuple-store-server)
	if [ -n "${ROLE}" ]
	then
		case ${ROLE} in
			tuple|tuplestore|tuple-store|t|tuple-store-server)
				ROLE=tuple-store
				;;
			*)
				ROLE=gungnir
				;;
		esac
	else
		ROLE=gungnir
	fi
	echo "role: ${ROLE}"

	## MongoDB
	if [ -n "${MONGO}" ]
	then
		echo "MongoDB: ${MONGO}"
		for i in ${MONGO//,/ }
		do
			MONGO_STR="${MONGO_STR}\n  - \"${i}\""
		done
	elif [ `env | grep -c 27017_TCP_ADDR` -gt 0 ]
	then
		for i in `env | grep 27017_TCP_ADDR | cut -d = -f 2`
		do
			MONGO_STR="${MONGO_STR}\n - \"${i}:27017\""
			MONGO_STR2="${MONGO_STR2},${i}:27017"
		done
		echo "MongoDB: ${MONGO_STR2:1}"
	else
		echo "[ERROR] not set MongoDB." >&2
		exit 1
	fi

	# change config.
	# * metastore.mongodb.servers
	# * mongo.fetch.servers
	# * mongo.persist.servers
	sed -i \
		-e "s/.*\(metastore\.mongodb\.servers\):.*/\1:${MONGO_STR}/g" \
		-e "s/.*\(mongo\.fetch\.servers\):.*/\1:${MONGO_STR}/g" \
		-e "s/.*\(mongo\.persist\.servers\):.*/\1:${MONGO_STR}/g" \
		${CONFIG}

	### ZooKeeper
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
			ZK_STR2="${ZK_STR2},${i}:2181"
		done
		echo "ZooKeeper: ${ZK_STR2:1}"
	else
		echo "[ERROR] not set ZooKeeper." >&2
		exit 1
	fi

	# change config.
	# * cluster.zookeeper.servers
	# * kafka.zookeeper.servers
	sed -i \
		-e "s/.*\(cluster\.zookeeper\.servers\):.*/\1:${ZK_STR}/g" \
		-e "s/.*\(kafka\.zookeeper\.servers\):.*/\1:${ZK_STR}/g" \
		${CONFIG}

	### Kafka
	if [ -n "${KAFKA}" ]
	then
		echo "Kafka: ${KAFKA}"
		for i in ${KAFKA//,/ }
		do
			KAFKA_STR="${KAFKA_STR}\n  - \"${i}\""
		done
	elif [ `env | grep -c 9092_TCP_ADDR` -gt 0 ]
	then
		for i in `env | grep 9092_TCP_ADDR | cut -d = -f 2`
		do
			KAFKA_STR="${KAFKA_STR}\n  - \"${i}:9092\""
			KAFKA_STR2="${KAFKA_STR2},${i}:9092"
		done
		echo "Kafka: ${KAFKA_STR2:1}"
	else
		echo "[ERROR] not set Kafka." >&2
		exit 1
	fi

	# change config.
	# * kafka.brokers
	# * kafka.emit.brokers
	sed -i \
		-e "s/.*\(kafka\.brokers\):.*/\1:${KAFKA_STR}/g" \
		-e "s/.*\(kafka\.emit\.brokers\):.*/\1:${KAFKA_STR}/g" \
		${CONFIG}

	### Storm
	if [ -n "${NIMBUS}" ]
	then
		echo "Nimbus: ${NIMBUS}"
	elif [ `env | grep -c 6627_TCP_ADDR` -gt 0 ]
	then
		NIMBUS=`env | grep 6627_TCP_ADDR | cut -d = -f 2`
		echo "Nimbus: ${NIMBUS}"
	else
		echo "[ERROR] not set Nimbus." >&2
		exit 1
	fi

	# change config.
	# * storm.cluster.mode
	# * storm.nimbus.host
	sed -i \
		-e "s/.*\(storm\.cluster\.mode\):.*/\1: \"distributed\"/g" \
		-e "s/.*\(storm\.nimbus\.host\):.*/\1: \"${NIMBUS}\"/g" \
		${CONFIG}

	### run
	su - gennai \
		/opt/gungnir-server/bin/${ROLE}-server.sh start \
		/opt/gungnir-server/conf/gungnir.yaml
}

### common
sed -i -e "s/WARN/INFO/g" /opt/gungnir-server/conf/logback.xml

### mode select
if [ -n "${MODE}" ]
then
	case ${MODE} in
		local|l|L|LOCAL)
			local_mode
			;;
		distributed|d|D|DISTRIBUTED)
			distributed_mode
			;;
		*)
			echo "[WARN] cannot select ${MODE}. run local mode." >&2
			local_mode
			;;
	esac
else
	local_mode
fi

sleep 3
tail -f /opt/gungnir-server/logs/gungnir.log

exec $@

# EOF
