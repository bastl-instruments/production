#!/bin/bash

cd ${0%/*}

interface_hex=Thyme-Interface.hex
processing_hex=Thyme-Processing.hex
LFUSE=FF
HFUSE=D9
EFUSE=05

while true; do
echo 
echo "================================="
echo "Which board do you want to flash?"
echo "================================="
echo 
echo "1. Interface"
echo "2. Processing"
read input
echo

if [ "$input" = 1 ]; then
echo "Flashing interface"
echo "=================="
avrdude -Pusb -cavrisp2 -pm328p -B100 -U efuse:w:0x"$EFUSE":m -U hfuse:w:0x"$HFUSE":m -U lfuse:w:0x"$LFUSE":m
avrdude -Pusb -cavrisp2 -pm328p -B1 -U flash:w:"$interface_hex":i
else
if [ "$input" = 2 ]; then
echo "Flashing Processing"
echo "==================="
st-flash write "$processing_hex" 0x08000000
else
echo "Wrong input"
fi
fi

done




