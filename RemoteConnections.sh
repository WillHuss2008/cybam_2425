#!/bin/bash
ports=$(ss -atupl state ESTABLISHED | awk '{print $4}' | cut -d':' -f2 | grep -v "local" | grep -Pv '[a-zA-Z]')
user=$(w | awk '$2 ~ /^pts/ {print $1}' | grep -v "-") 
ip=$(w | awk '$2 ~ /^pts/ {print $3}' | grep -v "-" | grep -Pv '[a-zA-Z]')

echo "Open Ports:
$ports
"

echo "Logins Today:
$user, $ip
"
echo "Boot Logs:
$(sudo grep "[  OK  ]" /var/log/boot.log.1 | tail -n 10)
"
