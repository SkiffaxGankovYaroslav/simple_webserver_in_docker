FROM ubuntu
LABEL desctiption="simple webserver based on netcat (nc). Start it with '-p 80:80'" creator="skiff"
RUN apt -y update && apt -y upgrade
RUN apt install -y net-tools nano curl wget netcat
COPY ./*.sh ./
#RUN ./install_docker_for_containers.sh
EXPOSE 80
RUN chmod 711 ./webserverskiff.sh
#RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
CMD ./webserverskiff.sh