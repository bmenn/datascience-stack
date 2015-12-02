FROM ubuntu:14.04
ENV HOME /root

RUN apt-get update -qq && apt-get install -qq curl unzip ssh openjdk-7-jre

COPY consul-template_0.11.1_linux_amd64.zip /tmp/consul-template.zip
RUN unzip /tmp/consul-template.zip -d /tmp && mv /tmp/consul-template /bin/consul-template && rm -rf /tmp/consul-template*

COPY hadoop-2.5.2.tar.gz /tmp/hadoop.tar.gz
RUN tar xf /tmp/hadoop.tar.gz -C /opt && rm /tmp/hadoop.tar.gz
COPY core-site.xml /etc/hadoop/core-site.xml
COPY hdfs-site.xml /etc/hadoop/hdfs-site.xml

# This doesn't work, sourcing files doesn't work
# ADD 00-java.sh /etc/profile.d/00-java.sh

# Source /etc/profile and /etc/profile.d/*
# Docker doesn't seem to pick these up
# RUN source /etc/profile
ENV JAVA_HOME=/usr
