#!/bin/bash

# look for available ports
ports=$(ss -atupl state ESTABLISHED | awk '{print $4}' | cut -d':' -f2 | grep -v "local" | grep -Pv '[a-zA-Z]')

# find the users and their ip
user=$(w | awk '$2 ~ /^pts/ {print $1}' | grep -v "-") 
ip=$(w | awk '$2 ~ /^pts/ {print $3}' | grep -v "-" | grep -Pv '[a-zA-Z]')

# echo all that stuff
echo "Open Ports:
$ports

Logins Today, $(date):
$user, $ip

Boot Logs:
$(sudo grep "[  OK  ]" /var/log/boot.log.1 | tail -n 10)
" >> /home/pi/Desktop/Logs/ConnectonLog.txt
