FROM node:6.13.1-stretch 

RUN apt-get update

ARG user=node
ARG group=node
ARG userid=1337
ARG groupid=1337
ARG userhome=/home/node

RUN usermod -u ${userid} ${user}
RUN groupmod -g ${groupid} ${group}

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

RUN mkdir -p /website

RUN chown ${user}:${group} /website
RUN chown -R ${user}:${group} /home/node

USER ${user}

ENTRYPOINT ["/usr/bin/entrypoint.sh"]

WORKDIR "/website"

