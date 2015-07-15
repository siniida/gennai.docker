#!/bin/bash

cd /opt/gungnir-server/bin
./gungnir-server.sh start conf/gungnir-standalone.yaml
sleep 10
/opt/gungnir-client/bin/gungnir -l -u root -p gennai
