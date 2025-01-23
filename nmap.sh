#!/bin/bash

network=$(ip addr | grep "inet " | awk {'print $2'} | sed -n 2p)
echo "$network"
nmap -sn $network | awk '
/^Nmap scan report/ { ip=$NF }
/^Mac Address:/ { mac=$3; name=substr($0, index($0, $4)); printf "%s - %s - %s\n", ip, mac, name }'
