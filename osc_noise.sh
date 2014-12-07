#!/bin/bash

PROGRAMMER="/dev/ttyUSB0"


avrdude -pm328p -carduino -P$PROGRAMMER -v -v -Uflash:w:osc_noise.hex:a

read -rsp $'Press any key or wait 5 seconds to continue...\n' -n 1 -t 5;
