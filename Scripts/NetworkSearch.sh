#!/bin/bash

gateway=$(route -n | grep UG | awk {'print $2'})
echo "beginning initial scan"
sudo nmap -sn $gateway/24 > file1
echo "please press the enter key when ready to continue"
read n
sudo nmap -sn $gateway/24 > file2

cat file1 | grep -v "Starting Nmap" | grep -v "Host is up" | grep -v "Nmap done" > scan1
cat file2 | grep -v "Starting Nmap" | grep -v "Host is up" | grep -v "Nmap done" > scan2

grep "Nmap" scan1 > ScanThrough1
grep "Nmap" scan2 > ScanThrough2

lines1=$(cat ScanThrough1 | wc -l)
lines2=$(cat ScanThrough2 | wc -l)

# scan 1
diff -y scan1 scan2
echo "


"

# scan 2
x=1
for i in $(seq 1 $lines1); do
    searchfor=$(sed -n "${x}p" ScanThrough1)
    if grep -q "$searchfor" ScanThrough2; then
        echo "
        $searchfor is still on"
        x=$((x + 1))

    elif ! grep -q "$searchfor" ScanThrough2; then
        echo "
        $searchfor disconnected between scans"
        x=$((x + 1))

    fi
done

# scan 3
y=1
for i in $(seq 1 $lines2); do
    searchfor=$(sed -n "${y}p" ScanThrough2)
    if grep -q "$searchfor" ScanThrough1; then
        y=$((y + 1))

    elif ! grep -q "$searchfor" ScanThrough1; then
        echo "
        $searchfor connected between scans"
        y=$((y + 1))

    fi
done
echo "$lines1, $lines2"

rm ScanThrough1 ScanThrough2 scan1 scan2 file1 file2
