FROM ubuntu:trusty
RUN ["apt-get", "update"]
RUN ["apt-get", "upgrade", "-y"]
RUN ["apt-get", "install", "-y", "default-jre-headless", "wget"]
RUN ["adduser", "--gecos", "Glowstone Server", "--disabled-password", "glowstone"]
USER glowstone
WORKDIR /home/glowstone
RUN ["wget", "http://bamboo.gserv.me/browse/GLOW-SRV/latest/artifact/shared/Glowstone-JAR/glowstone-0.0.1-SNAPSHOT-remapped.jar", "-O", "/home/glowstone/glowstone.jar"]
CMD ["/usr/bin/nohup", "/usr/bin/java", "-Xmx1G", "-Xms1G", "-jar", "/home/glowstone/glowstone.jar"]
EXPOSE 25565

