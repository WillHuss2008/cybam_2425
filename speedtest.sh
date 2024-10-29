#!/bin/bash
echo 'running script'

#pulling speed
speed=$(speedtest-cli --secure | grep "from\|Hosted\|Download\|Upload")
echo "$speed"

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
    rev="Your download speed is $down_rev but your upload speed is $up_rev"
else
    rev="Your download speed is $down_rev and your upload speed is $up_rev"
fi

log=speedlog.txt
echo "
$(date)
Network: $(sudo nmcli dev wifi show | awk {'print $2'} | sed -n '1p')
$speed
$rev
performed by $USER
" >> $log
