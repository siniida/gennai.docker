FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN curl http://ftp.riken.jp/net/apache/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz | tar zx -C /opt
RUN chown -R root:root /opt/apache-storm-0.9.4
RUN ln -s /opt/apache-storm-0.9.4 /opt/storm

ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 6627

ADD start.sh /usr/local/bin/
CMD ["/usr/local/bin/start.sh"]
