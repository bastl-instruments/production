cd ${0%/*}


if [ -d ".git" ]; then
	git checkout
else 
 	echo "no git repo found"
fi
