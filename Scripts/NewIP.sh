#!/bin/bash

# checking if they're sudo
if [[ $(id -u) -ne 0 ]]; then
    echo "permission denied"
    exit 1
fi

new_ip() {
    local ip=$1
    network=$(sudo nmcli con show --active | grep wifi | awk {'print $1'})
    echo $network
    read n
    sudo nmcli con mod "$network" ipv4.address "$ip"/24
    sudo nmcli con mod "$network" ipv4.gateway $(route -n | awk {'print $2'} | sed -n '3p')
    sudo nmcli con mod "$network" ipv4.dns $(route -n | awk {'print $2'} | sed -n '3p'),1.1.1.1
    sudo nmcli con mod "$network" ipv4.method manual
    sudo nmcli con up "$network"
}

random_mac() {
    touch hexfile
    echo "A
B
C
D
E
F
0
1
2
3
4
5
6
7
8
9" > hexfile

a="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
b="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
c="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
d="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
e="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
f="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
g="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
h="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
i="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
j="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
k="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"
l="$(shuf hexfile | tr -d '\n' | shuf | head -c 1)"

mac="$a$b:$c$d:$e$f:$g$h:$i$j:$k$l"
echo "$mac"

sudo nmcli con mod $(sudo nmcli con show --active | grep wifi | awk {'print $1'}) wifi.cloned-mac-address "$mac"
sudo nmcli con up $(sudo nmcli con show --active | grep wifi | awk {'print $1'})
rm hexfile
}

echo "hello"
network=$(sudo nmcli con show --active | grep wifi | awk {'print $1'})
echo "Network: $network
Ip: $(ifconfig wlan0 | grep 'inet ' | awk {'print $2'})
Mac: $(ifconfig wlan0 | grep 'ether' | awk {'print $2'})"

while true
do
    echo "please enter the last section of your new ip address '192.168.0.x'"
    read ip
    newip=$(echo "$(route -n | awk {'print $2'} | sed -n '3p')" | sed "s/\.[0-9]\+$/.$ip/")
    echo "$newip"
    if ! ping -c 1 -w 1 "$newip" &> /dev/null; then
        new_ip "$newip"
        echo "$newip
would you like to randomize your mac address?"
        read response
        if [[ "$response" = "yes" ]]; then
            random_mac
        else
            echo "please try again"
        fi
        break
    else
        echo "This one's taken.
    Please enter a different ip"
    fi
done
