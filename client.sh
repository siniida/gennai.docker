#!/bin/bash

PWD=`pwd`
BASE=`basename ${PWD} | sed -e 's/[\.\-]//g'`

docker run -ti --rm --link ${BASE}_zookeeper_1:zk --link ${BASE}_gungnir_1:gungnir --link ${BASE}_tuplestore_1:tuplestore siniida/gungnir-client
