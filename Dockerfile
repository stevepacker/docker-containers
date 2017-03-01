FROM php:7.1-fpm-alpine
MAINTAINER Stephen Packer <steve@stevepacker.com>

EXPOSE 80 443

ENTRYPOINT ["/sbin/tini", "--"]

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

# install php and other libraries
RUN apk -U add openssl git tar curl tini openssl ssmtp \
    # dependencies for PHP extensions below
	bzip2-dev \
        curl-dev \
        libxml2-dev \
        libpng-dev \
	imap-dev \
	icu-dev \
	libmcrypt-dev \
	sqlite-dev \
    # dependencies for PECL extensions below
        build-base \
        autoconf \
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
    && docker-php-ext-enable redis mongodb \
    && apk del build-base autoconf \
    && rm -rf /var/cache/apk/* \
    && echo "<?php phpinfo();" > /var/www/html/index.php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
     # I use Yii2 PHP Framework a lot, so I prefer this composer package be pre-installed
    && composer global require "fxp/composer-asset-plugin:^1.2.0" \
    && wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv caddy /usr/local/bin/caddy \
    && ln -sf /usr/local/etc/php /etc/php \
    && mkdir -p /srv \
    && rm -Rf /var/www/html \
    && ln -sf /srv /var/www/html \
    && echo "Done"

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

# Removing the volume definitions as it causes extending images to not be able to modify the files in these directories
# VOLUME ["/root/.caddy", "/srv"]

WORKDIR /srv

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]

