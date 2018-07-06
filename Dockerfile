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

ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
  && apt-get install -y --no-install-recommends openssh-server \
  && echo "$SSH_PASSWD" | chpasswd

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

# prepare nginx
RUN ln -s /home/site/wwwroot/conf/nginx.conf /etc/nginx/sites-available/default && \
	ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
	#RUN mkdir /etc/nginx/ssl && mkdir /etc/nginx/ssl/certs

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD bot/conf/nginx.conf /etc/nginx/

# set working directory
WORKDIR /home/site/wwwroot

EXPOSE 80
EXPOSE 443
EXPOSE 1880

# VOLUME [ "/etc/nginx/ssl/certs" ]
# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# CMD ["/bin/bash", "-c" , ".././framework/start.sh -p 1880 --env dev --docker --credential-secret chatbot123 bot"]
CMD .././framework/start.sh -p 1880 --env dev --docker --credential-secret chatbot123 bot