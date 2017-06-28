FROM debian:jessie 

COPY dotdeb.gpg /tmp/dotdeb.gpg

RUN echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list && \
    apt-key add /tmp/dotdeb.gpg && apt-get update  #Permet d'utiliser le cache
RUN apt-get install -y wget php7.0 php7.0-fpm

COPY php.ini /usr/local/php7/lib/php.ini
COPY www.conf /usr/local/php7/etc/php-fpm.d/www.conf
COPY php-fpm.conf /usr/local/php7/etc/php-fpm.conf
COPY php7-fpm.init /etc/init.d/php7-fpm

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64
RUN chmod +x /usr/local/bin/dumb-init

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/sbin/php-fpm7.0"]
