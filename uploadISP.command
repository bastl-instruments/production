#!/bin/bash

cd ${0%/*}

listOutput=$(ls *.hex)

LFUSE=FF
HFUSE=DF
EFUSE=FD


count=0
for j in $listOutput
do
	count=$(( count + 1 ))
	file[count]=$j
done

if [ "$count" = 0 ] ; then
	echo "No relevant HEX files"
	echo
    exit
fi

if [ "$count" = 1 ] ; then
    input=1
    echo "One relevant HEX file so selecting it automatically : ${file[$input]}"
    echo
else
    echo "The following is a list of the available HEX files:"
    echo
    i=0
    for j in $listOutput
    do
      i=$(( i + 1 ))
      echo "$i. $j"
    done
    echo
    echo "Choose a file number"
    echo
    read input
fi



echo "Flashing: ${file[$input]}"
echo
echo "##############################################################################"
echo


BINARY="avrdude"



"$BINARY" -pm328p -cavrisp2 -Pusb -B100 -U efuse:w:0x"$EFUSE":m -U hfuse:w:0x"$HFUSE":m -U lfuse:w:0x"$LFUSE":m
"$BINARY" -pm328p -cavrisp2 -Pusb -B1 -Uflash:w:"${file[$input]}":a

while read -s -n1 -p "Hit ENTER to run command again or ESC to restart" result; do

if [ "$result" = "$(echo -e '\033')" ]; then
	ScriptLoc=$(readlink -f "$0")
	exec "$ScriptLoc"
fi


"$BINARY" -pm328p -cavrisp2 -Pusb -B100 -U efuse:w:0x"$EFUSE":m -U hfuse:w:0x"$HFUSE":m -U lfuse:w:0x"$LFUSE":m
"$BINARY" -pm328p -cavrisp2 -Pusb -B1 -Uflash:w:"${file[$input]}":a	
done
