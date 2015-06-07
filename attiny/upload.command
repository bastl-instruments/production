#!/bin/bash

cd ${0%/*}

PROGRAMMER=$(head -n 1 ../programmer)


listOutput=$(ls *.hex)

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

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	BINARY="avrdude"
	CONF="/etc/avrdude.conf"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	BINARY="../avrdude.mac"
	CONF="../avrdude.conf.mac"
else
	echo "Operating system not supported"
fi


"$BINARY" -C"$CONF" -pattiny85 -cstk500v1 -P"$PROGRAMMER" -b19200 -vv -e -Uefuse:w:0xff:m -Uhfuse:w:0xdf:m -Ulfuse:w:0xe2:m
"$BINARY" -C"$CONF" -pattiny85 -cstk500v1 -P"$PROGRAMMER" -b19200 -vv -Uflash:w:"${file[$input]}":a 

while read -p "Hit ENTER to redo operation" ; do
"$BINARY" -C"$CONF" -pattiny85 -cstk500v1 -P"$PROGRAMMER" -b19200 -v -e -Uefuse:w:0xff:m -Uhfuse:w:0xdf:m -Ulfuse:w:0xe2:m
"$BINARY" -C"$CONF" -pattiny85 -cstk500v1 -P"$PROGRAMMER" -b19200 -v -Uflash:w:"${file[$input]}":a 
done



 



