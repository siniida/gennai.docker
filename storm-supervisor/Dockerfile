FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN groupadd -r storm
RUN useradd -r -g storm storm

RUN curl http://ftp.riken.jp/net/apache/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz | tar zx -C /opt
RUN ln -s /opt/apache-storm-0.9.4 /opt/storm
RUN mkdir /opt/storm/logs
RUN chown -R storm:storm /opt/apache-storm-0.9.4

ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 6700 6701 6702 6703

WORKDIR /opt/storm

ADD start.sh /usr/local/bin/
CMD ["/usr/local/bin/start.sh"]
