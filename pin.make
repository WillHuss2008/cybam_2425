#!/bin/bash
for i in $(seq 1 1000); do
    line="$(cat pinsource | sed -n ${i}p)"
    line="$((line))"
    if [[ "$line" -le 9 && "$line" -ge 0 ]]; then
        echo "000$line" >> pin.txt
    elif [[ "$line" -le 99 && "$line" -ge 10 ]]; then
        echo "00$line" >> pin.txt
    elif [[ "$line" -le 999 && "$line" -ge 100 ]]; then
        echo "0$line" >> pin.txt
    elif [[ "$line" -le 9999 && "$line" -ge 1000 ]]; then
        echo "$line" >> pin.txt
    fi
done
