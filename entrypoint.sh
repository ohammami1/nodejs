#!/bin/sh

#npm install --save-dev webpack@3.4.1
#npm install --save-dev webpack-dev-server@2.6.1
#npm install --save-dev webpack-cli@2.0.10


if [ -z $ENV ]; then
	echo "No ENV set, assuming local"
	export ENV="local"
fi

if [ $ENV != "prod" ]; then
	npm install -g mocha@5.0.1 \
		istanbul@0.4.5 \
		apidoc@0.17.6 \
		webpack@3.10.0 
fi

npm install

npm start

tail -f /dev/null

exec "$@"

