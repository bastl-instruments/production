#!/bin/bash

PROGRAMMER=$(head -n 1 ../programmer)

avrdude -pm328p -carduino -P/dev/"$PROGRAMMER" -v -v -Uflash:w:osc_noise.hex:a

read -rsp $'Press any key or wait 5 seconds to continue...\n' -n 1 -t 5;
