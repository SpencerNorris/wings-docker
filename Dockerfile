FROM r-base
MAINTAINER Varun Ratnakar varunratnakar@gmail.com
RUN sed -i 's/debian testing main/debian testing main contrib non-free/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y install graphviz curl unzip curl openssl libssl-dev libcurl4-openssl-dev libxml2-dev python-pip tomcat8
RUN apt-get -y install samtools tophat cufflinks
RUN pip install RSeQC
RUN mkdir -p /opt/wings/storage/default /opt/wings/server
ADD http://www.wings-workflows.org/downloads/docker/latest/portal/wings-portal.xml /etc/tomcat8/Catalina/localhost/wings-portal.xml
ADD http://www.wings-workflows.org/downloads/docker/latest/portal/portal.properties /opt/wings/storage/default/portal.properties
RUN cd /opt/wings/server && curl -O http://www.wings-workflows.org/downloads/docker/latest/portal/wings-portal.war && unzip wings-portal.war && rm wings-portal.war
RUN sed -i 's/Resource name="UserDatabase" auth/Resource name="UserDatabase" readonly="false" auth/' /etc/tomcat8/server.xml
RUN sed -i 's/=tomcat8/=root/' /etc/default/tomcat8
RUN sed -i 's/<\/tomcat-users>/ <user username="admin" password="4dm1n!23" roles="WingsUser,WingsAdmin"\/>\n<\/tomcat-users>/' /etc/tomcat8/tomcat-users.xml
ADD http://www.wings-workflows.org/downloads/docker/latest/domain/R-install.R /tmp/R-install.R
RUN Rscript /tmp/R-install.R
RUN chown tomcat8:tomcat8 /etc/tomcat8/tomcat-users.xml
RUN mkdir /var/lib/tomcat8/temp && chown -R tomcat8:tomcat8 /var/lib/tomcat8/temp
RUN ln -sf bash /bin/sh
CMD service tomcat8 start && /bin/bash