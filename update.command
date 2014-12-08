if [ -d ".git" ]; then
	git pull
else 
	git clone git://github.com/bastl-instruments/production	
fi
git pull
