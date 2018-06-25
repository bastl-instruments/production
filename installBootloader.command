#!/bin/bash

cd ${0%/*}

LFUSE=FF
HFUSE=D6
EFUSE=FD

BOOTLOADER_HEX=arduino_bootloader.hex

read -p "Hit ENTER to start" 


echo "Flashing Arduino Bootloader"
echo
echo "##############################################################################"
echo


if [[ "$OSTYPE" == "linux-gnu" ]]; then
	BINARY="avrdude"
	CONF="/etc/avrdude.conf"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	BINARY="./avrdude.mac"
	CONF="./avrdude.conf.mac"
else
	echo "Operating system not supported"
fi

 
"$BINARY" -C"$CONF" -pm328p -cavrisp2 -Pusb -B100 -U efuse:w:0x"$EFUSE":m -U hfuse:w:0x"$HFUSE":m -U lfuse:w:0x"$LFUSE":m 
"$BINARY" -C"$CONF" -pm328p -cavrisp2 -Pusb -B1 -Uflash:w:"$BOOTLOADER_HEX":a




