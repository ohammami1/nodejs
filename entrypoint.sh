#!/usr/bin/env bash

ENV_NAMES=$(export | cut -d' ' -f 3- | cut -d'=' -f 1)

DIST_FILE=/website/${DIST_DIR}/config.js.dist
CONF_FILE=/website/${DIST_DIR}/config.js

if ! [ -f ${DIST_FILE} ] || ! [ ${DIST_DIR} ]; then
	echo "No Dist File, skipping configurations..."
else
        cp ${DIST_FILE} ${CONF_FILE}
        
        for i in ${ENV_NAMES}; do
        	#echo "ENV: s/__${i}__/${!i}/g"
        	if [ -z ${!i} ]; then continue; fi
        	if echo ${!i} | grep '/' >/dev/null 2>&1 ; then continue; fi
        
        	sed -i ${CONF_FILE} -e "s/__${i}__/${!i}/g"
        done
        
        if cat ${CONF_FILE} | grep '__' >/dev/null 2>&1 ; then
        	echo "Warning: They're still unbound variables in ${CONF_FILE}, you probabely didn't define those in your environment section"
        fi
        
fi

export PATH=${PATH}:$(pwd)/node_modules/.bin
printf "\nexport PATH=$PATH\n\n" >> ~/.bashrc

if [ -z $ENV ]; then
	echo "No ENV set, assuming local"
	export ENV="local"
fi

if [ $ENV = "prod" ]; then
 	npm install --production
	npm install --save pm2
	npm run start:prod
else
	npm install --progress=false
	npm start
fi

tail -f /dev/null

