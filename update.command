if [ -d ".git" ]; then
	git checkout
else 
	git clone git://github.com/bastl-instruments/production	
fi
git pull