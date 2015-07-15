FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-server-0.0.1-20150612.tar.gz | tar zx -C /opt
RUN chown -R root:root /opt/gungnir-server-0.0.1
RUN ln -s /opt/gungnir-server-0.0.1 /opt/gungnir-server

ENV JAVA_HOME /usr/lib/jvm/jre

EXPOSE 7200

ADD start.sh /usr/local/bin/

CMD ["/usr/local/bin/start.sh"]
