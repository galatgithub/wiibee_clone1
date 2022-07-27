#!/bin/bash

hcitool scan
echo -ne "scan on" | bluetoothctl
echo -ne "scan off" | bluetoothctl
BTRLADDR="76:7F:0B:01:65:00"

echo -ne "agent on" | bluetoothctl

echo -ne "trust 76:7F:0B:65:00" | bluetoothctl

echo -ne "pair 76:7F:0B:65:00" | bluetoothctl

sudo rfcomm bind 0 $BTRLADDR

sudo chmod o+rw /dev/rfcomm0

#ls -l /dev/rfcomm0

for i in 1 2 3 4; do

echo -ne "\xA0\x01\x01\xA2" > /dev/rfcomm0 & pidbt=$!

sleep 5
kill $pidbt 2>/dev/null

echo -ne "\xA0\x01\x00\xA1" > /dev/rfcomm0 & pidbt=$!

sleep 4
kill $pidbt 2>/dev/null
done



