#!/bin/bash

#следующий цикл не пригодился
# for i in {1..5} ; do
#     temparray[$i]=$i*$i
#     echo "position $i: ${temparray[$i]}"
# done
# exit

#старт основного бесконечного цикла
while true; do
    #ip_to_get=192.168.42.228
    ip_to_get=localhost
    if [ "$1" != "" ] ; then #если параметр передан, то перезаписываем его
        ip_to_get=$1
    fi
    port_to_get=80
    time_to_sleep=.2
    time_period=7 #период между повторениями запросов
    #check availability of the address
    echo "===NEXT ITERATION=== ===NEXT ITERATION WITH $ip_to_get:$port_to_get==="
    nc -zv $ip_to_get $port_to_get > /dev/null
    if [ $? == 0 ] ; then #если связь есть, то продолжаем получать данные
        echo -e "\n---------first variant nc (netcat)"
        echo -e "\n---------first variant nc (netcat)" >> log_to_get_url.log
        sleep $time_to_sleep
        result1=$(echo -e "GET / nah / give me this url ept" | nc $ip_to_get $port_to_get -w 4)
        echo "$(date '+%D %R:%S'): $result1"
        echo "$(date '+%D %R:%S'): $result1" >> log_to_get_url.log
        #second variant tcp
        echo -e "\n---------second variant /dev/tcp/"
        sleep $time_to_sleep
        result1=$(echo -n "GET me by tcp" >/dev/tcp/$ip_to_get/$port_to_get)
        echo "$(date '+%D %R:%S'): $result1"
        #third variant udp
        echo -e "\n---------third variant /dev/upd/"
        sleep $time_to_sleep
        result1=$(echo -n "GET me by udp" >/dev/udp/$ip_to_get/$port_to_get)
        echo "$(date '+%D %R:%S'): $result1"
        #four variant wget
        echo -e "\n---------four variant wget port 80"
        sleep $time_to_sleep
        result1=$(wget -O- "http://$ip_to_get")
        echo "$(date '+%D %R:%S'): $result1"
        #five variant wget
        echo -e "\n---------five variant curl"
        sleep $time_to_sleep
        result1=$(curl -G "http://$ip_to_get:$port_to_get")
        echo "$(date '+%D %R:%S'): $result1"
        #six variant telnet
        echo -e "\n--------six variant telnet"
        sleep $time_to_sleep
        result1=$(telnet $ip_to_get $port_to_get)
        echo "$(date '+%D %R:%S'): $result1"
        echo -e "\n\n"
    else
        echo "polomato. No connection"
        break
        exit
    fi
    sleep $time_period
done