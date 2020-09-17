FROM openjdk:11-jre-slim
LABEL maintainer="Synoa GmbH <we@synoa.de>"

# Set the Timezone to CET/CEST
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# So we don't need to change all Dockerfiles if we change the java version
RUN ln -fs /usr/local/openjdk-11/bin/java /usr/bin/java

# Set caching of DNS entries to 5 seconds. Default is forever!! https://stackoverflow.com/a/48808685/6504528
RUN echo "networkaddress.cache.ttl=5" >> $JAVA_HOME/conf/security/java.security

# Install Tomcat native performance library
RUN apt update
RUN apt install libtcnative-1 -y

# Clean up apt cache and repositories to be slim again
RUN apt autoremove --purge -y
RUN apt clean autoclean
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

# This can be overriden and used to configure the amount of Memory used by a Service
ENV _JAVA_OPTIONS="-XX:+UseContainerSupport"
