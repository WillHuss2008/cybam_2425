#!/bin/bash

open_port() {
    local port=$1
    sudo iptables -A INPUT -p tcp --dport $port -j ACCEPT
    python3 -m http.server $port
    wait
    kill -9 $(pstree -p | grep python3 | grep -o '[0-9]\+')
    sudo iptables -D INPUT -p tcp --dport $port -j ACCEPT
}

num_check() {
    local port=$1
    if nc -zv 127.0.0.1 $port | grep "open"; then
        echo "this port is already open."
        exit 0
    else
        echo "would you like to open this port for scanning?"
        read response
        if [[ "$response" = "yes" ]]; then
            open_port $port
        elif [[ "$response" = "no" ]]; then
            exit 0
        fi
    fi
}

echo "please enter the port number that you would like to open. Must be between 11000 and 65535"
read port
port=$(($port))

if [ $port -lt 11000 ];then
    echo "please enter a port number between 11000 and 65535"

elif [ $port -gt 65535 ]; then
    echo "Error: this port does not exist"
    echo "please enter a port number between 11000 and 65535"

else
    num_check $port
fi

