## -*- docker-image-name: wings:0.1 -*-
FROM bitnami/tomcat:latest
MAINTAINER Spencer Norris <norris@rpi.edu>
RUN apt-get update && apt-get install -y wget
ADD . /
RUN mkdir -p /bitnami/tomcat/data
WORKDIR /bitnami/tomcat/data
RUN ["wget", "http://www.wings-workflows.org/sites/default/files/wings-portal-4.0-SNAPSHOT.war"]
RUN chmod +x /configure.sh
EXPOSE 80
#ENTRYPOINT /configure.sh
