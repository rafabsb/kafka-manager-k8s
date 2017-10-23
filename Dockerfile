# Created from sheepkiller/kafka-manager-docker
FROM centos:7

MAINTAINER Rafael Muller <rafabsb@github>

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-headless && \
    yum clean all

ENV JAVA_HOME=/usr/java/default/ \
    KM_VERSION=1.3.3.14 \
    KM_REVISION=04907ee737757369653969aadb6e1668c013fad2 \
    KM_CONFIGFILE="conf/application.conf"

RUN yum install -y java-1.8.0-openjdk-devel git wget unzip which nc && \
    mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    yum autoremove -y java-1.8.0-openjdk-devel git wget unzip which && \
    yum clean all

WORKDIR /kafka-manager-${KM_VERSION}
