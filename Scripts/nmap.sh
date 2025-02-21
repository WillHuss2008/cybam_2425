#!/bin/bash
if [[ $(id -u) -ne 0 ]]; then
    echo "permission denied"
    exit 0
fi
echo "please enter the gateway ip to scan"
read network
echo "please enter the network's bit number"
read bit
echo "scan 1
" > /home/pi/Desktop/Class/Text_Files/scannedfor1
scan1=$(sudo nmap -sn $network/$bit | awk '
/^Nmap scan report/ {ip=$NF} /^MAC Address/ {mac=$3; name=substr($0, index($0, $4)); printf "%s - %s - %s\n", ip, mac, name}')
echo "$scan1" >> /home/pi/Desktop/Class/Text_Files/scannedfor1
echo "please press the enter key when ready to continue"
read n
echo "scan 2
" > /home/pi/Desktop/Class/Text_Files/scannedfor2
scan2=$(sudo nmap -sn $network/$bit | awk '
/^Nmap scan report/ {ip=$NF} /^MAC Address/ {mac=$3; name=substr($0, index($0, $4)); printf "%s - %s - %s\n", ip, mac, name}')
echo "$scan2" >> /home/pi/Desktop/Class/Text_Files/scannedfor2
diff -y /home/pi/Desktop/Class/Text_Files/scannedfor1 /home/pi/Desktop/Class/Text_Files/scannedfor2
echo "would you like to remove the scan files?"
read answer
if [[ "$answer" = "yes" ]]; then
    sudo rm /home/pi/Desktop/Class/Text_Files/scannedfor1 /home/pi/Desktop/Class/Text_Files/scannedfor2
fi
