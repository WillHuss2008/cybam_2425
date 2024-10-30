#!/bin/bash

removelog="/home/pi/Desktop/Logs/removelog"

if [ $# -eq 0 ]; then
    echo "Error"
    echo "Argument: Please enter a list of files or directories to delete"
fi

if [ "$1" = "-s" ]; then
    shift $#
    /bin/rm $@
elif [ "$1" = "-r" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-rs" ]; then
    shift $#
    /bin/rm -r $@
elif [ "$1" = "-f" ]; then
    shift
    /bin/rm -f $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-i" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-I" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-d" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-v" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog

elif [ "$1" = "-fs" ]; then
    shift $@
    /bin/rm -f $@
elif [ "$1" = "-is" ]; then
    shift $@
    /bin/rm -r $@
elif [ "$1" = "-Is" ]; then
    shift $@
    /bin/rm -r $@
elif [ "$1" = "-ds" ]; then
    shift $@
    /bin/rm -r $@
elif [ "$1" = "-vs" ]; then
    shift $@
    /bin/rm -r $@
else
    echo "$(date): $USER: $@" >> $removelog
    /bin/rm $@
fi
exit 0
