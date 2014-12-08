cd ${0%/*}


if [ -d ".git" ]; then
	git pull
else 
 	echo "no git repo found"
fi
