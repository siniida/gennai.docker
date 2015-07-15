#!/bin/bash

docker run -ti --rm --link gennaidocker_zookeeper_1:zk --link gennaidocker_gungnir_1:gungnir --link gennaidocker_tuplestore_1:tuplestore siniida/gungnir-client
