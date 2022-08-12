#!/bin/bash
#cd simple_webserver_in_docker #заходим в папку с локальным git-репозиторием
#git clone https://github.com/SkiffaxGankovYaroslav/simple_webserver_in_docker.git
git checkout master
docker stack deploy -c swarm_file_skiff.yml skiffswarm