#!/bin/bash

removelog="/home/pi/Desktop/removelog"

if [ $# -eq 0 ]; then
    echo "Error"
    echo "Argument: Please enter a list of files or directories to delete"
fi

if [ "$1" = "-s" ]; then
    shift 
else
    echo "$(date): $USER: $@" >> $removelog
fi
/bin/rm $1
exit 0
