#!/bin/bash
cd ${0%/*}


if [ -d ".git" ]; then
	git pull
else 
 	echo "no git repo found"
fi

read -p "Hit ENTER to exit"
