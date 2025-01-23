#!/bin/bash
log='/home/pi/Desktop/Logs/speedlog.txt'
echo 'running script'

#pulling speed
speed=$(speedtest-cli --secure | grep "from\|Hosted\|Download\|Upload")

#pulling download speed
download=$(echo "$speed" | grep "Download" | awk {'print int($2)'} | grep -v Mbit) 
if [[ $download -le 40 ]]; then
    down_rev="bad"
else
    down_rev="good"
fi

#pulling upload speed
upload=$(echo "$speed" | grep "Upload" | awk {'print int($2)'} | grep -v Mbit) 
if [[ $upload -le 40 ]]; then
    up_rev="bad"
else
    up_rev="good"
fi

#leaving a review
if [[ $download -le 40 || $upload -le 40 ]]; then
    echo "$(date): $USER
$speed
    
Your download speed is $down_rev but your upload speed is $up_rev
    
    " >> $log
   
else
    echo "$(date): $USER
$speed
    
Your downlad speed is $down_rev and your upload speed is $up_rev
    
    " >> $log
fi
