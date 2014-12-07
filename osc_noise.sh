#!/bin/bash
avrdude -pm328p -carduino -P"$1" -v -v -Uflash:w:osc_noise.hex:a
