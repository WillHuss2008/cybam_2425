#!/bin/bash
while true; 
do
    if netstat -antcp | grep -q ":22.*ESTABLISHED"; then
        sudo kill -9 $(pstree -p | grep sshd | grep -o '[0-9]\+')
        sudo iptables -A INPUT -p tcp --dport 22 -j DROP
        echo "Port 22 closed for reconfiguration."
        SSID=$(sudo nmcli connection show --active | grep wifi | awk '{print $2}')  # Fixed syntax
        ip_public=$(hostname -I | awk '{print $1}')  # Fixed the syntax here
        ip_gateway=$(route -n | awk 'NR==3 {print $2}')  # Simplified this line
        for ip in $(seq 1 254); 
        do
            # Construct the new IP address
            new_ip=$(echo "$ip_gateway" | sed "s/\.[0-9]\+$/.$ip/")
            ip_new=$(echo "$new_ip" | sed "s/\.[0-9]\+$/.$(shuf -i 1-255 -n 1)/")
    
            # Check if the IP is reachable
            if ! ping -c 1 -w 1 "$new_ip" &> /dev/null; then
                # Modify the connection with the new IP address
                sudo nmcli con mod "$SSID" ipv4.addresses $ip_new/24
                sudo nmcli con mod "$SSID" ipv4.gateway "$ip_gateway"
                sudo nmcli con mod "$SSID" ipv4.dns "$ip_gateway, 0.0.0.0, 1.1.1.1, 1.0.0.1, 8.8.8.8, 8.8.4.4"
                sudo nmcli con mod "$SSID" ipv4.method manual
                sudo nmcli con up "$SSID"
                break  # Exit after modifying the first available IP
            fi
        done
        sudo iptables -D INPUT -p tcp --dport 22 -j DROP
        echo "Port 22 open for use."
    else
        echo "no ssh connections"
    fi
done
