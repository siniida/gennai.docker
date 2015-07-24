FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN groupadd -r kafka
RUN useradd -r -g kafka kafka

RUN curl http://ftp.riken.jp/net/apache/kafka/0.8.2.1/kafka_2.10-0.8.2.1.tgz | tar zx -C /opt
RUN ln -s /opt/kafka_2.10-0.8.2.1 /opt/kafka
RUN mkdir /opt/kafka/kafka-logs
RUN chown -R kafka:kafka /opt/kafka_2.10-0.8.2.1
RUN sed -i -e 's/^\(log.dirs\)=.*/\1=\/opt\/kafka\/kafka\-logs/g' /opt/kafka/config/server.properties

EXPOSE 9092

WORKDIR /opt/kafka

ADD start.sh /usr/local/bin/
CMD ["/usr/local/bin/start.sh"]
