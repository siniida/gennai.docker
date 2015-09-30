# siniida/gungnir-server

[![](https://badge.imagelayers.io/siniida/gungnir-server:latest.svg)](https://imagelayers.io/?images=siniida/gungnir-server:latest 'Get your own badge on imagelayers.io')

for [gennai](http://genn.ai/) cluster. ([gennai.docker](https://github.com/siniida/gennai.docker))

## Mode

### local mode

    $ docker run -d \
        -e MODE=local \
        siniida/gungnir-server


### distributed mode

run gungnir-server. (default)

    $ docker run -d \
        --hostname gungnir \
        -e MODE=distributed \
        -e MONGO=[MongoDBContainerName]:[port] \
        -e ZOOKEEPER=[ZKContainerName]:[port] \
        -e KAFKA=[KafkaContainerName]:[port] \
        -e NIMBUS=[NimbusContainerName] \
        siniida/gungnir-server
    
    or
    
    $ docker run -d \
        --hostname gungnir1 \
        -e MODE=distributed \
        -e ROLE=gungnir-server \
        -e MONGO=[MongoDBContainerName1]:[port],[MongoDBContainerName2]:[port],.. \
        -e ZOOKEEPER=[ZKContainerName1]:[port],[ZKContainerName2]:[port],... \
        -e KAFKA=[KafkaContainerName1]:[port],[KafkaContainerName2]:[port],... \
        -e NIMBUS=[NimbusContainerName] \
        siniida/gungnir-server

run tuple-store-server.

    $ docker run -d \
        --hostname tuplestore \
        -e MODE=distributed \
        -e ROLE=tuplestore \
        -e MONGO=[MongoDBContainerName]:[port] \
        -e ZOOKEEPER=[ZKContainerName]:[port] \
        -e KAFKA=[KafkaContainerName]:[port] \
        -e NIMBUS=[NimbusContainerName] \
        siniida/gungnir-server

**Require**

* MongoDB
* Apache ZooKeeper
* Apache Kafka
* Apache Storm

### with MongoDB

change config.

* metastore.mongodb.servers
* mongo.fetch.servers
* mongo.persist.servers

ex)

    $ docker run -d \
        -e MODE=distributed \
        -e MONGO=[MongoDBContainerName]:[port] \
        -e ZOOKEEPER=[ZKContainerName]:[port] \
        siniida/gungnir-server
    
    or
    
    $ docker run -d \
        -e MODE=distributed \
        -e MONGO=[MongoDBContainerName1]:[port],[MongoDBContainerName2]:[port],... \
        -e ZOOKEEPER=[ZKContainerName1]:[port],[ZKContainerName2]:[port],... \
        siniida/gungnir-server

### with Kafka

change config.

* kafka.brokers
* kafka.zookeeper.servers
* kafka.emit.brokers

ex)

    $ docker run -d \
        -e MODE=distributed \
        -e KAFKA=[KafkaContainerName]:[port] \
        -e ZOOKEEPER=[ZKContainerName]:[port] \
        siniida/gungnir-server
    
    or
    
    $ docker run -d \
        -e MODE=distributed \
        -e KAFKA=[KafkaContainerName1]:[port],[KafkaContainerName2]:[port],... \
        -e ZOOKEEPER=[ZKContainerName1]:[port],[ZKContainerName2]:[port],... \
        siniida/gungnir-server

### with Apache Storm

change config.

* storm.cluster.mode
* storm.nimbus.host

ex)

    $ docker run -d \
        -e ROLE=distributed \
        -e NIMBUS=[NimbusContaineName] \
        -e ZOOKEEPER=[ZKContainerName]:[port] \
        siniida/gungnir-server

