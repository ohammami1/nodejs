#!/bin/sh

#npm install --save-dev webpack@3.4.1
#npm install --save-dev webpack-dev-server@2.6.1
#npm install --save-dev webpack-cli@2.0.10

export PATH=${PATH}:$(pwd)/node_modules/.bin
printf "\nexport PATH=$PATH\n\n" >> ~/.bashrc

if [ -z $ENV ]; then
	echo "No ENV set, assuming local"
	export ENV="local"
fi

if [ -z $NODE_LOG_PATH ]; then
	echo "No Log Path Specified, if you wish to get logs add NODE_LOG_PATH var to your environment"
	export NODE_LOG_PATH=/proc/self/fd/1
fi

npm install --progress=false >> $NODE_LOG_PATH

if [ $ENV = "prod" ]; then
	npm start:prod
else
	npm start
fi

tail -f /dev/null

