# image ununtu
FROM ubuntu:14.04

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# add basic lib
RUN apt-get update && apt-get -y install software-properties-common nginx build-essential curl python2.7 wget unzip && \
	ln -s /usr/bin/python2.7 /usr/bin/python2 && \
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
	apt-get -y install nodejs && \
	npm install -g pm2

#create folders
RUN mkdir -p /home/site && \
	mkdir -p /home/site/framework && \
	mkdir -p /home/site/wwwroot

# add framework & bot data
ADD viseo-bot-framework /home/site/framework
ADD bot /home/site/wwwroot

# npm install
RUN cd /home/site/framework && npm install && \
	cd /home/site/wwwroot/data && npm install

# set working directory
WORKDIR /home/site/wwwroot

EXPOSE 80
EXPOSE 443
EXPOSE 1880

# CMD ["/bin/bash", "-c" , ".././framework/start.sh -p 1880 --env dev --docker --credential-secret chatbot123 bot"]
CMD .././framework/start.sh -p 1880 --env dev --docker --credential-secret chatbot123 bot