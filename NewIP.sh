#!/bin/bash
# still get mac, network, ip address
#  take down your interface
#  ifconfig wlan0 down
#  THEN change the mac, then bring the network back
#

# checking if they're sudo
if [[ $(id -u) -ne 0 ]]; then
    echo "permission denied"
    exit 1
fi
network="$(sudo nmcli dev wifi show | grep SSID | awk {'print $2'})"
ip="$(hostname -I)"
mac="$(ifconfig wlan0 | grep ether | awk {'print $2'})"
gateway="$(route -n | awk {'print $2'} | sed -n '3p')"

echo "welcome to the mac changer
network: $network
IP: $ip
Mac: $mac

would you like to continue?"
read response
if [[ "$response" = "no" ]]; then
    exit 0
fi

#mac changer

touch hexfile.txt
echo "a
b
c
d
e
f
1
2
3
4
5
6
7
8
9
0" > hexfile.txt

a=$(shuf hexfile.txt | head -1)
b=$(shuf hexfile.txt | head -1)
c=$(shuf hexfile.txt | head -1)
d=$(shuf hexfile.txt | head -1)
e=$(shuf hexfile.txt | head -1)
f=$(shuf hexfile.txt | head -1)
g=$(shuf hexfile.txt | head -1)
h=$(shuf hexfile.txt | head -1)
i=$(shuf hexfile.txt | head -1)
j=$(shuf hexfile.txt | head -1)
k=$(shuf hexfile.txt | head -1)
l=$(shuf hexfile.txt | head -1)

newmac="34:5e:08:$g$h:$i$j:$k$l"

echo "this is your new mac address
mac: $newmac"
sudo ifconfig wlan0 down
sudo nmcli con mod $network wifi.cloned-mac-address $newmac
echo "please press the enter key when ready to continue"
read n
sudo nmcli con up $network
echo "please press the enter key when ready to continue"
read n
sudo ifconfig wlan0 up
echo "would you like to change your ip address as well?"
read response
if [[ "$resopnse" = "no" ]]; then
    exit 1
fi
echo "what would you like to change your ip to? (192.168.0.x)"
while true
do
    read new
    new_ip=$(echo "$gateway" | sed "s/\.[0-9]\+$/.$new/")
    echo "
your new ip: $new_ip"
    if ! ping -c 1 -w 1 "$new_ip" &> /dev/null; then
        sudo nmcli con mod "$network" ipv4.addresses "$new_ip"/24
        sudo nmcli con mod "$network" ipv4.gateway "$gateway"
        sudo nmcli con mod "$network" ipv4.dns "$gateway",1.1.1.1
        sudo nmcli con mod "$network" ipv4.method manual
        echo "press the enter key when ready to continue"
        read n
        sudo nmcli con up "$network"
        break
    else
        echo "that ip is taken, please enter a new ip"
    fi
done
