#!/bin/sh

#npm install --save-dev webpack@3.4.1
#npm install --save-dev webpack-dev-server@2.6.1
#npm install --save-dev webpack-cli@2.0.10

if [ -z $ENV ]; then
	echo "No ENV set, assuming local"
	export ENV="local"
fi

if [ -z $NODE_LOG_PATH ]; then
	echo "No Log Path Specified, if you wish to get logs add NODE_LOG_PATH var in you environment"
	export NODE_LOG_PATH=/dev/null
fi

if [ $ENV != "prod" ]; then
	wait -n
	npm install --loglevel=warn --progress=false -g mocha@5.0.1 \
		istanbul@0.4.5 \
		apidoc@0.17.6 \
		webpack@3.10.0 \
		nodemon@1.17.2 > $NODE_LOG_PATH
fi

wait -n
npm --loglevel=warn --progress=false install > $NODE_LOG_PATH

if [ $ENV == "prod" ]; then
	npm start:prod
else
	npm start
fi

tail -f /dev/null

