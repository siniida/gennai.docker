FROM centos:6

MAINTAINER siniida

# RUN yum install -y which git
RUN useradd gennai

ADD provision/*.sh /tmp/
ADD files/init/* /etc/rc.d/init.d/

# common
RUN /tmp/system.sh
RUN /tmp/jdk.sh

# mongodb
ADD files/mongodb.repo /etc/yum.repos.d/
RUN yum install -y mongodb-org tar sudo

RUN /tmp/zookeeper.sh
RUN /tmp/kafka.sh
RUN /tmp/storm.sh
RUN /tmp/gungnir.sh

ADD files/kafkaServer /opt/kafka/bin/

# clean
RUN rm /tmp/*

