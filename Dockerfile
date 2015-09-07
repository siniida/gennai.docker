FROM centos:6

MAINTAINER siniida <sinpukyu@gmail.com>

RUN yum update -y
RUN yum install -y tar java-1.7.0-openjdk

ENV JAVA_HOME /usr/lib/jvm/jre


# gungnir
RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-server-0.0.1-20150814.tar.gz | tar zx -C /opt
RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-client-0.0.1-20150814.tar.gz | tar zx -C /opt
RUN ln -s /opt/gungnir-server-0.0.1 /opt/gungnir-server
RUN ln -s /opt/gungnir-client-0.0.1 /opt/gungnir-client
RUN chown -R root:root /opt/gungnir-server-0.0.1
RUN chown -R root:root /opt/gungnir-client-0.0.1
RUN sed -i -e 's/WARN/INFO/g' /opt/gungnir-server/conf/logback.xml

ADD start.sh /usr/local/bin/

CMD ["/usr/local/bin/start.sh"]
