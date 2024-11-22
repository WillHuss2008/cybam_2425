#!/bin/bash


#list of network SSID's
Wifi_list=("Row1" "Pod2" "Pod3" "Pod4" "EVSC-CS" "CYB_Rogue")

# create a variable stating that we haven't found any networks
found=0


# a function that connects to x network given to us in the following script
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

# list the network so that the device can find them
sudo nmcli dev wifi list
echo "which network would you like to access?"
read SSID

# look for said network in our wifi_list
for network in "${Wifi_list[@]}"; 
do
    # if it finds the network, then it will perform the function with the SSID we provided
    if [[ "${Wifi_list[@]}" =~ "${SSID}" ]]; then
        Wifi_Matrix "$SSID"
        break
    else
        # if it doesn't find the network, then you can still access a network on the list with it's password
        sudo nmcli dev wifi connect $SSID --ask 

    fi
done
