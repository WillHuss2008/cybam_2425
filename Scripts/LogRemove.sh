#!/bin/bash

# assign a file variable. This is where our log will go.
removelog="/home/pi/Desktop/Logs/removelog.txt"

# print back an error text if there are no arguments
if [ $# -eq 0 ]; then
    echo "Error"
    echo "Argument: Please enter a list of files or directories to delete"
fi


# adding /bin/rm options to our script

# don't log this removal
if [ "$1" = "-s" ]; then
    shift $#
    # use the built-in remove tool (rm) located in /bin to delete all the arguments ($@)
    /bin/rm $@

# remove this directory and all files within it.
elif [ "$1" = "-r" ]; then
    shift
    /bin/rm -r $@
    # add the date, user, and file(s) being removed to our file variable
    echo "$(date): $USER: $@" >> $removelog

# remove directory and files within silently
elif [ "$1" = "-rs" ]; then
    shift $#
    /bin/rm -r $@

# ignore nonexistent files and arguments
elif [ "$1" = "-f" ]; then
    shift
    /bin/rm -f $@
    echo "$(date): $USER: $@" >> $removelog

# remove but prompt before they're removed
elif [ "$1" = "-i" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog

# pretty much the same as -i
elif [ "$1" = "-I" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog

# you get the point: there's a bunch of options
elif [ "$1" = "-d" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog
elif [ "$1" = "-v" ]; then
    shift
    /bin/rm -r $@
    echo "$(date): $USER: $@" >> $removelog

# silent options
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

# exiting the script
exit 0
