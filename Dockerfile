# Created from sheepkiller/kafka-manager-docker
FROM centos:7

MAINTAINER Rafael Muller <rafabsb@github>

RUN yum update -y && \
    yum install -y java-1.8.0-openjdk-headless && \
    yum clean all

ENV JAVA_HOME=/usr/java/default/ \
    KM_VERSION=1.3.1.8 \
    KM_REVISION=97329cc8bf462723232ee73dc6702c064b5908eb \
    KM_CONFIGFILE="conf/application.conf"

ADD kafka-manager-help.sh /kafka-manager-${KM_VERSION}/kafka-manager-help.sh

RUN yum install -y java-1.8.0-openjdk-devel git wget unzip which && \
    mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    chmod +x /kafka-manager-${KM_VERSION}/kafka-manager-help.sh && \
    yum autoremove -y java-1.8.0-openjdk-devel git wget unzip which && \
    yum clean all

WORKDIR /kafka-manager-${KM_VERSION}

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["./kafka-manager-help.sh"]
