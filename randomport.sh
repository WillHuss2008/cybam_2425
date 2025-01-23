#!/bin/bash
port=$(shuf -i 1024-65535 -n 1)
echo "Opening port $port"
nc -lk $port & LISTENER_PID=$!
echo "$LISTENER_PID"
echo "Port $port is now open. enter CTRL+C to stop"
wait $LISTENER_PID
