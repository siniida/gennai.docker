FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN groupadd -r zookeeper
RUN useradd -r -g zookeeper -s /sbin/nologin zookeeper

RUN curl http://ftp.tsukuba.wide.ad.jp/software/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar zx -C /opt
RUN ln -s /opt/zookeeper-3.4.6 /opt/zookeeper
RUN mkdir /opt/zookeeper/data
RUN chown -R zookeeper:zookeeper /opt/zookeeper-3.4.6
RUN mv /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg
RUN sed -i -e 's/^\(dataDir\)=.*/\1=\/opt\/zookeeper\/data/g' /opt/zookeeper/conf/zoo.cfg

ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

ENTRYPOINT ["/opt/zookeeper-3.4.6/bin/zkServer.sh"]
CMD ["start-foreground"]
