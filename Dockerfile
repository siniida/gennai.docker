FROM centos:6

MAINTAINER siniida <sinpukyu@gmail.com>

# mongodb repository
ADD files/mongodb.repo /etc/yum.repos.d/

RUN useradd gennai

RUN echo "*    soft    nofile   32768" >> /etc/security/limits.conf
RUN echo "*    hard    nofile   32768" >> /etc/security/limits.conf
RUN sed -i \
  -e 's/^\(\*.*\)/#\1\n\*\tsoft\tnproc\t63228\n\*\thard\tnproc\t63228/g' \
  /etc/security/limits.d/90-nproc.conf

# jdk
RUN curl -L -O https://s3-ap-northeast-1.amazonaws.com/gennai/binary/jdk-7u71-linux-x64.rpm >/dev/null 2>&1
RUN rpm -ivh ./jdk-7u71-linux-x64.rpm >/dev/null 2>&1
RUN ln -s /usr/java/default/bin/jps /usr/bin/jps
RUN echo "" >> /home/gennai/.bashrc
RUN echo "export JAVA_HOME=/usr/java/default" >> /home/gennai/.bashrc
RUN echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" >> /home/gennai/.bashrc
RUN rm jdk-7u71-linux-x64.rpm

# mongodb
RUN yum install -y mongodb-org tar

# zookeeper
RUN curl http://archive.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar zx -C /opt
RUN ln -s /opt/zookeeper-3.4.6 /opt/zookeeper
RUN chown -R gennai:gennai /opt/zookeeper-3.4.6
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
RUN echo "" >> /home/gennai/.bashrc
RUN echo "export ZOOKEEPER_HOME=/opt/zookeeper" >> /home/gennai/.bashrc
RUN echo "export PATH=\${ZOOKEEPER_HOME}/bin:\${PATH}" >> /home/gennai/.bashrc
RUN echo "export ZOO_LOG_DIR=/opt/zookeeper" >> /home/gennai/.bashrc

# kafka
RUN curl https://archive.apache.org/dist/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz | tar zx -C /opt
RUN ln -s /opt/kafka_2.10-0.8.2.1 /opt/kafka
RUN chown -R gennai:gennai /opt/kafka_2.10-0.8.2.1
RUN echo "" >> /home/gennai/.bashrc
RUN echo "export KAFKA_HOME=/opt/kafka" >> /home/gennai/.bashrc
RUN echo "export PATH=\${KAFKA_HOME}/bin:\${PATH}" >> /home/gennai/.bashrc
ADD files/kafkaServer /opt/kafka/bin/

# storm
RUN curl https://archive.apache.org/dist/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz | tar zx -C /opt
RUN ln -s /opt/apache-storm-0.9.4 /opt/storm
RUN mkdir /opt/storm/storm-local/
RUN chown -R gennai:gennai /opt/apache-storm-0.9.4
RUN sed -i \
  -e 's/^# \(storm.zookeeper.servers:\)$/\1\n    - "localhost"/g' \
  /opt/storm/conf/storm.yaml
RUN sed -i \
  -e 's/^# \(nimbus.host: \)"nimbus"$/\1 "localhost"/g' \
  /opt/storm/conf/storm.yaml
RUN echo 'storm.local.dir: "/opt/storm/storm-local"' >> /opt/storm/conf/storm.yaml

# gungnir
RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-server-0.0.1-20150612.tar.gz | tar zx -C /opt
RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-client-0.0.1-20150612.tar.gz | tar zx -C /opt
RUN ln -s /opt/gungnir-server-0.0.1 /opt/gungnir-server
RUN ln -s /opt/gungnir-client-0.0.1 /opt/gungnir-client
RUN chown -R gennai:gennai /opt/gungnir-server-0.0.1
RUN chown -R gennai:gennai /opt/gungnir-client-0.0.1
RUN sed -i \
  -e 's/# \(cluster.mode:.*\)/\1/g' \
  -e 's/# \(cluster.zookeeper.servers:.*\)/\1\n  \- \"localhost:2181\"/g' \
  /opt/gungnir-client/conf/gungnir.yaml
RUN sed -i -e 's/^# \(storm.cluster.mode: .*\)$/\1/g' /opt/gungnir-server/conf/gungnir.yaml
RUN echo "" >> /home/gennai/.bashrc
RUN echo "export GUNGNIR_HOME=/opt/gungnir-client" >> /home/gennai/.bashrc
RUN echo "export PATH=\${GUNGNIR_HOME}/bin:\${PATH}" >> /home/gennai/.bashrc

# init script
ADD files/init/* /etc/rc.d/init.d/

# TODO: CMD
