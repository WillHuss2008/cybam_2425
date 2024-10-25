#!/bin/bash
echo 'running script'
speed=$(speedtest-cli --secure | grep "from\|Hosted\|Download\|Upload")
echo "$speed"

download=$speed | awk '/Download/ {print $2}' | sed 's/[^0-9.]//g'
echo "$donwload"
