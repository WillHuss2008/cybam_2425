#!/bin/bash

# Get the public IP address
ip_public=$(hostname -I | awk '{print $1}')  # Fixed the syntax here
ip_gateway=$(route -n | awk 'NR==3 {print $2}')  # Simplified this line
SSID=$(sudo nmcli connection show --active | grep Auto | awk '{print $1, $2}')  # Fixed syntax

# Check for established SSH connections
searching=$(netstat -tnp | grep ":22.*ESTABLISHED")

# Get PIDs of sshd processes
killing=$(pstree -p | grep sshd | awk -F '[()]' '{print $2}')  # Fixed syntax

# Function to reconfigure network
reconfigure_network() {
    for ip in $(seq 1 254); do
        # Construct the new IP address
        new_ip=$(echo "$ip_public" | sed "s/\.[0-9]\+$/.$ip/")
        
        # Check if the IP is reachable
        if ! ping -c 1 -w 1 "$new_ip" &> /dev/null; then
            # Modify the connection with the new IP address
            sudo nmcli con mod "$SSID" ipv4.addresses 192.168.1.$ip/24
            sudo nmcli con mod "$SSID" ipv4.gateway "$ip_gateway"
            sudo nmcli con down "$SSID"
            sudo nmcli con up "$SSID"
            break  # Exit after modifying the first available IP
        fi
    done
}

# Check if there are established connections
if [ -n "$searching" ]; then
    echo "Someone has accessed your device."
    sudo kill -9 $killing
    sudo iptables -A INPUT -p tcp --dport 22 -j DROP
    echo "Port 22 closed for reconfiguration."
    reconfigure_network
    sudo iptables -D INPUT -p tcp --dport 22 -j DROP
    echo "Port 22 open for use."
fi

