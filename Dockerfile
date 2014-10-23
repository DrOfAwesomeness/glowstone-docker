FROM ubuntu:trusty
RUN ["apt-get", "update"]
RUN ["apt-get", "upgrade", "-y"]
RUN ["apt-get", "install", "-y", "default-jre-headless", "wget"]
RUN ["mkdir /glowstone"]
WORKDIR /glowstone
RUN ["wget", "http://ci.chrisgward.com/job/Glowstone/lastSuccessfulBuild/artifact/build/libs/glowstone.jar"]
CMD ["/usr/bin/nohup", "/usr/bin/java", "-Xmx1G", "-Xms1G", "-jar", "/glowstone/glowstone.jar"]
EXPOSE 25565

