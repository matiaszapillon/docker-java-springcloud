# syntax=docker/dockerfile:1

FROM ubuntu:18.04 AS build
# Java 8
ADD jdk* /usr/local/

#Using ADD is the same than doing the following commands:
#COPY jdk* /usr/local
#RUN cd /usr/local/ && tar -zxvf jdk1.8.0_181
#RUN rm jdk-8u181-linux-x64.tar.gz

#It is recommended to use COPY instead of ADD

# Install dependencies
RUN apt-get update && apt-get install -y apt-utils wget curl nano unzip && \
# Maven 3.5
#    wget https://archive.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -O maven35.tar.gz &&\
#    tar -xzvf maven35.tar.gz && rm maven35.tar.gz &&\
#\
cd /usr/local && curl -fsSL -O "https://www.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz" && \
tar -zxvf apache-maven-3.6.3-bin.tar.gz

RUN mkdir -p /home/developer && mkdir -p /home/developer/workspace && mkdir -p /home/developer/workspace/discovery-server

#COPY .bashrc /home/developer/


# Tomcat
#    wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.88/bin/apache-tomcat-7.0.88.tar.gz -O tomcat.tar.gz &&\
#   tar -xzvf tomcat.tar.gz && rm tomcat.tar.gz && mv apache-tomcat-* tomcat && chmod 777 -R tomcat &&\
#\

ENV MAVEN_VERSION 3.6.3
ENV MAVEN_HOME "/usr/local/apache-maven-$MAVEN_VERSION"
ENV JAVA_HOME "/usr/local/jdk1.8.0_181"

ENV PATH="$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH"


# Set timezone
#RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata sudo &&\
#    ln -fs /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime &&\
#\

# Other apps
RUN apt-get install -y less && \
    apt-get install -y git && \
    apt-get install -y sshpass && \
    apt-get install -y ssh

#    mkdir -p /home/developer && mkdir -p /home/developer/workspace && \
#    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
#    echo "developer:x:1000:" >> /etc/group && \
#    sudo echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
#    sudo chmod 0440 /etc/sudoers.d/developer && \
#    sudo chown developer:developer -R /home/developer && \
#    sudo chown root:root /usr/bin/sudo && \
#    chmod 4755 /usr/bin/sudo && \
#\
# Set env vars
   # mkdir -p /home/developer && mkdir -p /home/developer/workspace && \
   # echo 'export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH' >> /home/developer/.bashrc 

# File deploy de script

#USER developer
ENV HOME /home/developer
WORKDIR /home/developer/workspace/

# Define variables de entorno que dependienden del repositorio git
#RUN echo "source /home/developer/workspace/sis/sis_dev_env.sh" >> /home/developer/.bashrc

COPY /discovery-server /home/developer/workspace/discovery-server
RUN cd /home/developer/workspace/discovery-server/ ; mvn clean install 
