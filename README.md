gennai.docker
=========

all in one gennai for docker.

## How

    $ docker build -t gennai .
    $ docker run -ti --rm gennai /bin/bash

## in container

    # service mongod start
    # service zookeeper start
    # service kafka start
    # service storm-nimbus start
    # service storm-supervisor start
    # service gungnir-server start
    # service tuple-store-server start
    #
    # /opt/gungnir-client/bin/gungnir -u root -p gennai

## other mode

* standalone mode

    $ git checkout standalone

* cluster mode (require docker-compose)

    $ git checkout cluster
