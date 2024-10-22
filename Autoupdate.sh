#!/bin/bash
echo begining update
echo 
sudo apt update
echo
echo update complete 
echo 
echo begining upgrade
echo 
sudo apt upgrade
echo 
echo upgrade complete
echo 
echo begining autoclean
echo 
sudo apt autoclean
echo 
echo autoclean complete
echo 
echo begining autoremove
echo 
sudo apt autoremove
echo
echo autoremove complete
echo 
echo Thank you. Would you like to shutdown, reboot, or exit?
read response
if [ $response = "shutdown" ]; then
    sudo shutdown now
elif [ $response = "reboot" ]; then
    sudo reboot now
elif [ $response = "exit" ]; then
    clear
fi
    
