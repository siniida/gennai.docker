FROM centos:6
MAINTAINER siniida

RUN yum update -y
RUN yum install -y java-1.7.0-openjdk tar

RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-client-0.0.1-20150814.tar.gz | tar zx -C /opt
RUN chown -R root:root /opt/gungnir-client-0.0.1
RUN ln -s /opt/gungnir-client-0.0.1 /opt/gungnir-client

ENV JAVA_HOME /usr/lib/jvm/jre

ADD start.sh /usr/local/bin/

CMD ["/usr/local/bin/start.sh"]
