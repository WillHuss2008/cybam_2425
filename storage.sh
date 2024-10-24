#!/bin/bash

store=$(df -h | awk {'print $5'} | sed -n '4p')
storage=${store//%/}

if [[ $storage -ge 0 && $storeage -le 69 ]]; then
    echo $storage
    echo "you're good on storage for now"

elif [[ $storage -ge 70 && $storeage -le 79 ]]; then
    echo $storage
    echo "you're running a little low on storage there"


elif [[ $storage -ge 80 && $storeage -le 89 ]]; then
    echo $storage
    echo "you need to clear some storage"

elif [[ $storage -ge 90 && $storeage -le 99 ]]; then
    echo $storage
    echo "you need to clear some storage"

elif [[ $storage -eq 80 ]]; then
    echo $storage
    echo "you need to clear some storage"

fi
