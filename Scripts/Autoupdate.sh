#!/bin/bash

# welcome the user and give them the date
echo "
Hello, $USER, it is $(date)
"

# update the device
sudo apt update
echo "update complete at $(date)
"

# upgrade and cleanup the device
sudo apt upgrade
sudo apt autoremove
sudo apt autoclean
echo "upgrade complete at $(date)
"
# end the script with some options
echo "would you like to reboot, or shutdown your pi?"
read input
x=0

# options for device
while [ $x = "0" ]
do
    if [ $input = "reboot" ]; then
        sudo reboot now
    elif [ $input = "shutdown" ]; then
        sudo shutdown now
    elif [ $input = "neither" ]; then
        break
    else
       break 
    fi
done
