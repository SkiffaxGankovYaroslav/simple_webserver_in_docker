FROM ubuntu
LABEL description="client get to server. Run with command as IP of a webserver" creator="skiff"
RUN apt -y update && apt -y upgrade
RUN apt install -y net-tools nano curl wget netcat telnet
COPY ./*.sh ./
#RUN ./install_docker_for_containers.sh
EXPOSE 80
RUN chmod 711 ./get_url_simple_webserver.sh
#RUN apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
ENTRYPOINT [ "/get_url_simple_webserver.sh" ]
CMD [ "skiffswarm_webserver_skiff" ]