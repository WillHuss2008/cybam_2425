#!/bin/bash
for i in $(seq 1 1000); do
    line=$(cat pinsource | sed -n ${i}p)
    line=$((line))
