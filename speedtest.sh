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
<<<<<<< HEAD
    up_rev="good"    
=======
    up_rev="good"
>>>>>>> 32e22444ddb23f717e3751f4ef22af4d8a2001e9
fi

#leaving a review
if [[ $download -le 40 || $upload -le 40 ]]; then
<<<<<<< HEAD
    rev="Your download speed is $down_rev but your upload speed is $up_rev"
else
    rev="Your download speed is $down_rev and your upload speed is $up_rev"
=======
    echo "$(date): $USER
$speed
    
Your download speed is $down_rev but your upload speed is $up_rev
    
    " >> $log
   
else
    echo "$(date): $USER
$speed
    
Your downlad speed is $down_rev and your upload speed is $up_rev
    
    " >> $log
>>>>>>> 32e22444ddb23f717e3751f4ef22af4d8a2001e9
fi

log=speedlog.txt
echo "
$(date)
Network: $(sudo nmcli dev wifi show | awk {'print $2'} | sed -n '1p')
$speed
$rev
performed by $USER
" >> $log
