FROM php:7.1-fpm-alpine
MAINTAINER Stephen Packer <steve@stevepacker.com>

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "--"]

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

# install php and other libraries
RUN apk -U add openssl git tar curl tini openssl ssmtp \
    && apk add --virtual build-dependencies \
	bzip2-dev \
        curl-dev \
        libxml2-dev \
        libpng-dev \
	imap-dev \
	icu-dev \
	libmcrypt-dev \
	sqlite-dev \
    && docker-php-ext-install \
	bcmath \
	bz2 \
	ctype \
	curl \
	dom \
	gd \
	hash \
	iconv \
	imap \
	intl \
	json \
	mbstring \
	mcrypt \
	opcache \
	pcntl \
	pdo \
	pdo_mysql \
	pdo_sqlite \
	phar \
	posix \
	session \
	simplexml \
	sockets \
	xml \
	zip \
    && pecl install mongodb redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
    && echo "<?php phpinfo();" > /var/www/html/index.php \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv caddy /usr/local/bin/caddy \
    && ln -sf /usr/local/etc/php /etc/php \
    && ln -sf /var/www/html /srv \
    && echo "Done"

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]

