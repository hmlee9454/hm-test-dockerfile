FROM rockylinux:8.10

RUN dnf -y update && \
    dnf -y install java-1.8.0-openjdk-devel wget tar procps-ng && \
    dnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

ARG TOMCAT_VERSION=8.5.100
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/ && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]