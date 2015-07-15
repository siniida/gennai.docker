FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN curl http://ftp.riken.jp/net/apache/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz | tar zx -C /opt
RUN chown -R root:root /opt/kafka_2.10-0.8.2.1
RUN ln -s /opt/kafka_2.10-0.8.2.1 /opt/kafka
RUN mkdir /opt/kafka/kafka-logs
RUN sed -i -e 's/^\(log.dirs\)=.*/\1=\/opt\/kafka\/kafka\-logs/g' /opt/kafka/config/server.properties

EXPOSE 9092

ADD start.sh /usr/local/bin/
CMD ["/usr/local/bin/start.sh"]
