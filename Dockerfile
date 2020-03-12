FROM openjdk:11-jre-slim
LABEL maintainer="Synoa GmbH <we@synoa.de>"

# Set the Timezone to CET/CEST
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# Install Tomcat native performance library
RUN apt update
RUN apt install libtcnative-1

# Clean up apt cache and repositories
RUN apt autoremove --purge -y
RUN apt clean autoclean
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

# This can be overriden and used configure the amount of Memory used by a Service
ENV _JAVA_OPTIONS="-Xms64m -Xmx128m"
