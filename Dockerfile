FROM node:6.13.1-stretch 

RUN apt-get update && apt-get install -y curl

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir -p /website

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

WORKDIR "/website"

