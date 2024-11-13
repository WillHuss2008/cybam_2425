#!/bin/bash

store=$(df -h | awk {'print $5'} | sed -n '4p')
storage=${store//%/}
log='/home/pi/Desktop/Logs/storelog.txt'

if [[ $storage -ge 0 && $storeage -le 69 ]]; then
    echo "$(date):$USER
Storage:$storage%
you're good on storage for now
" >> $log

elif [[ $storage -ge 70 && $storeage -le 79 ]]; then
    echo "$(date):$USER
Storage:$storage%
you're running a little low on storage there
" >> $log


elif [[ $storage -ge 80 && $storeage -le 89 ]]; then
    echo "$(date):$USER
Storage:$storage%
you need to clear some storage
" >> $log

elif [[ $storage -ge 90 && $storeage -le 99 ]]; then
    echo "$(date):$USER
Storage:$storage%
you need to clear some storage
" >> $log

elif [[ $storage -eq 80 ]]; then
    echo "$(date):$USER
Storage:$storage%
you need to clear some storage
" >> $log

fi
