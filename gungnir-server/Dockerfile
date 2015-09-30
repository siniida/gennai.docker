FROM centos:6
MAINTAINER siniida <sinpukyu@gmail.com>

RUN yum update -y
RUN yum install -y tar

RUN groupadd -r gennai
RUN useradd -g gennai gennai

RUN curl -L -O -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.rpm
RUN rpm -ivh jdk-7u80-linux-x64.rpm && rm jdk-7u80-linux-x64.rpm

RUN curl https://s3-ap-northeast-1.amazonaws.com/gennai/gungnir-server-0.0.1-20150814.tar.gz | tar zx -C /opt
RUN ln -s /opt/gungnir-server-0.0.1 /opt/gungnir-server
RUN mkdir -p /opt/gungnir-server/logs
RUN chown -R gennai:gennai /opt/gungnir-server-0.0.1

RUN yum clean all

ENV JAVA_HOME /usr/java/default

EXPOSE 7100 7200 7300

WORKDIR /opt/gungnir-server

ADD entry.sh /

ENTRYPOINT ["/entry.sh"]
