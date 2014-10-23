FROM ubuntu:trusty
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y default-jre-headless wget python2.7 python-pip
RUN pip install requests pyyaml
RUN adduser --gecos "Glowstone Server" --disabled-password glowstone
USER glowstone
WORKDIR /home/glowstone
COPY run.py /home/glowstone/
COPY glowstone.yml.dist /home/glowstone/
RUN wget http://bamboo.gserv.me/browse/GLOW-SRV/latest/artifact/shared/Glowstone-JAR/glowstone-0.0.1-SNAPSHOT-remapped.jar -O /home/glowstone/glowstone.jar
CMD /usr/bin/python run.py
EXPOSE 25565

