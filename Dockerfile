FROM ubuntu:focal

# initial repo setup
RUN apt-get update
RUN apt-get install -y software-properties-common

# install stuff
RUN apt-get install -y \
	apache2 \
	nginx \
	curl

# setup apache config
RUN rm /etc/apache2/sites-enabled/*
COPY config/apache.conf /etc/apache2/sites-available/test.conf
COPY config/ports.conf /etc/apache2/ports.conf
RUN a2ensite test

# setup nginx config
COPY config/nginx.conf /etc/nginx/nginx.conf

# create unreadable file (read by root only) for webservers
RUN mkdir -p /var/www/test
RUN touch /var/www/test/index.html
RUN chmod 554 /var/www/test

# setup boot
COPY config/boot.sh /root
RUN chmod +x /root/boot.sh
CMD ["/root/boot.sh"]
