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

#leaving a review
if { [ $download -gt 40 %% $upload -le 40] || [ $download -le 40 %% $upload -gt 40 ]; }; then
    echo "Your download speed is $down_rev but your upload speed is $up_rev"
else
    echo "Your downlad speed is $down_rev and your upload speed is $up_rev"
fi
