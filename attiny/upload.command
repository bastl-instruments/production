#!/bin/bash

cd ${0%/*}

PROGRAMMER=$(head -n 1 ../programmer)


files=$(ls *.hex)
i=0
for j in $files
do
i=$(( i + 1 ))
	file[i]=$j
done

 if [ "$i" = 0 ] ; then
	echo "No relevant HEX files"
	echo 
    exit
fi

if [ "$i" = 1 ] ; then
    input=1
    echo "One relevant HEX file so selecting it automatically : ${file[$input]}"
    echo
else
    echo "The following is a list of the available HEX files:"
    echo 
    i=0
    for j in $files
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


avrdude -pattiny85 -cstk500v1 -P"$PROGRAMMER" -v -v -Uflash:w:"$files[input]":a -b19200

while read -p "Hit ENTER to redo operation" ; do
avrdude -pattiny85 -cstk500v1 -P"$PROGRAMMER" -v -v -Uflash:w:"$files[input]":a -b19200
done



#files=$(ls *.hex)
#i=0

#for j in $files
#do
#    i=$(( i + 1 ))
#done

#if [ "$i" = 0 ] ; then
#  echo "No hex file found"
#  echo 
#  exit
#fi

#if [ "$i" = 1 ] ; then


