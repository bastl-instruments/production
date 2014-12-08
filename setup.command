#!/bin/bash

echo "The following is a list of the available serial ports:"
echo 



sport=$(ls /dev/)
i=0
for j in $sport
do
if [[ "$j" == tty* ]] ; then
    i=$(( i + 1 ))
    echo "$i. $j"
    port[i]=$j
fi
done

echo

if [ "$i" = 0 ] ; then
  echo "No relevant port"
  echo 
  exit
fi

if [ "$i" = 1 ] ; then
  inputp=1
  echo "One relevant port so selecting it automatically : "
  else
  echo "Select which port to write to :"
  echo
  read inputp
fi

echo "/dev/${port[$inputp]}" > programmer

echo
echo "##############################################################################"
echo


