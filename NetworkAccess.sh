#!/bin/bash

Wifi_list=("Row1" "Pod2" "Pod3" "Pod4" "EVSC-CS" "CYB_Rogue")

found=0


Wifi_Matrix() {
    local x=$1
    if [ $x = "1" ]; then
        sudo nmcli dev wifi connect Row1 password S3cureMe!
    elif [ $x = "2" ]; then
        sudo nmcli dev wifi connect Pod2 password C@ntfindMe!
    elif [ $x = "3" ]; then
        sudo nmcli dev wifi connect Pod3 password M1ssngNm
    elif [ $x = "4" ]; then
        sudo nmcli dev wifi connect Pod4 password S@feWay3!
    elif [ $x = "CS" ]; then
        sudo nmcli dev wifi connect EVSC-CS password Andr01d$
    elif [ $x = "Rogue" ]; then 
        sudo nmcli dev wifi connect CYB_Rogue password D0ntT3llem1
    fi
}

sudo nmcli dev wifi list
echo "which network would you like to access?"
read SSID
for network in "${Wifi_list[@]}"; 
do
    if [[ "${Wifi_list[@]}" =~ "${SSID}" ]]; then
        Wifi_Matrix "$SSID"
        break
    else
        echo "enter password"
        read pass
        sudo nmcli dev wifi connect $SSID password $pass

    fi
done
