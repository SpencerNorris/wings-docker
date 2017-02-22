## -*- docker-image-name: wings:0.1 -*-
FROM tomcat:9.0
MAINTAINER Spencer Norris <norris@rpi.edu>
RUN apt-get update && apt-get install -y wget

# Install Python
#RUN pip install --upgrade pip
#RUN pip install --upgrade virtualenv

#Drop WINGS image into webapps
WORKDIR ${CATALINA_HOME}/webapps
RUN [ "wget", "http://www.wings-workflows.org/sites/default/files/wings-portal-4.0-SNAPSHOT.war", "-O", "wings-portal.war" ]
RUN chmod 755 wings-portal.war

#Add configuration files to ${CATALINA_HOME}/conf
WORKDIR ..
RUN ls -al conf/
RUN rm ./conf/tomcat-users.xml
ADD tomcat-users.xml ./conf/tomcat-users.xml
RUN chmod 600 ./conf/tomcat-users.xml
RUN rm ./conf/server.xml
ADD server.xml ./conf/server.xml
RUN chmod 600 ./conf/server.xml
RUN ls -al conf/

#Start Tomcat
#RUN python3 config.py
#RUN ls -al ${CATALINA_HOME}/bin
#RUN test -e ${CATALINA_HOME}/bin/catalina.sh
WORKDIR ${CATALINA_HOME}/bin/
CMD ["catalina.sh", "run"]
#RUN ${CATALINA_HOME}/bin/shutdown.sh
#CMD ['${CATALINA_HOME}/bin/startup.sh']
