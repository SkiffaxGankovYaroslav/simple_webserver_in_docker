#!/bin/bash
#it is the simple webserver. It use command 'nc'
while true; do
    # -l means listening port, 
    # -p means which port is listening
    # -q means timeout in seconds when connection should refused
    echo -e "HTTP/1.1 200 OKnn It's you f*cking site. You are crazy, now time is $(date)" | nc -lp 80 -4 -q 0
#    sleep 1
done