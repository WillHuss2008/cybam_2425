#!/bin/bash
#
nmcli dev wifi list
nmcli dev wifi connect CYB_Rogue password D0ntT3llem1

echo "enter switch number"
read number
if [ $number = "1" ]; then
    echo "accessing switch number 1"
    ssh pi@192.168.0.17
elif [ $number = "2" ]; then
    echo "accessing swtich number 2"
    ssh pi@192.168.0.246
elif [ $number = "3" ]; then
    echo "accessing switch number 3"
    ssh pi@192.168.0.46
elif [ $number = "4" ]; then
    echo "accessing switch number 4"
    ssh pi@192.168.0.44
elif [ $number = "5" ]; then
    echo "accessing switch number 5"
    ssh pi@192.168.0.5
elif  [ $number = "8" ]; then
    echo "accessing switch number 8"
    ssh pi@192.168.0.96
elif [ $number = "9" ]; then
    echo "accessing switch number 9"
    ssh pi@192.168.0.43
elif [ $number = "10" ]; then
    echo "accessing switch number 10"
    ssh pi@192.168.0.51
elif [ $number = "11" ]; then
    echo "accessing switch number 11"
    ssh pi@192.168.0.208
elif [ $number = "12" ]; then
    echo "accessing switch number 12"
    ssh pi@192.168.0.64
elif [ $number = "13" ]; then
    echo "accessing switch number 13"
    ssh pi@192.168.0.80
elif [ $number = "14" ]; then
    echo "accessing switch number 14"
    ssh pi@192.168.0.212
elif [ $number = "15" ]; then
    echo "accessing swtich number 15"
    ssh pi@192.168.0.63
elif [ $number = "16" ]; then
    echo "accessing switch number 16"
    ssh pi@192.168.0.100
elif [ $number = "17" ]; then
    echo "accessing switch number 17"
    ssh pi@192.168.0.176
elif [ $number = "20" ]; then
    echo "accessing switch number 20"
    ssh pi@192.168.0.93
elif [ $number = "21" ]; then 
    echo "accessing switch number 21"
    ssh pi@192.168.0.173
elif [ $number = "22" ]; then
    echo "accessing switch number 22"
    ssh pi@192.168.0.228
elif [ $number = "7" ]; then
    echo "this switch port is not being used"
elif [ $number = "18" ]; then
    echo "this switch port is not being used"
elif [ $number = "19" ]; then
    echo "this switch port is not being used"
elif [ $number = "6" ]; then
    echo "this is the wifi port"
else
    echo "this either doesn't exist or you mispelled something"
fi
