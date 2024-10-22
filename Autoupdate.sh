#!/bin/bash
#
echo "Hello, $USER, it is $(date)"
sudo apt update
echo " "
echo "update complete at $(date)"
echo " "
echo " "
sudo apt upgrade
sudo apt autoremove
sudo apt autoclean
echo " "
echo "upgrade complete at $(date)"
echo " "
echo " "
echo "would you like to reboot, or shutdown your pi?"
read input
x=0
while [ $x = "0" ]
do
    if [ $input = "reboot" ]; then
        sudo reboot now
    elif [ $input = "shutdown" ]; then
        sudo shutdown now
    elif [ $input = "neither" ]; then
        break 
    fi
done
