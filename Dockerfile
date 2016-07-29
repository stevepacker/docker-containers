FROM alpine:3.4
MAINTAINER Stephen Packer <steve@stevepacker.com>

EXPOSE 80 443

# install php and other libraries
RUN echo "http://dl-3.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
    && apk add --update openssl git tar curl \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fpm \
        php7-gd \
        php7-iconv \
        php7-imap \
        php7-intl \
        php7-json \
        php7-mcrypt \
        php7-mbstring \
        php7-openssl \
        php7-pcntl \
        php7-pdo_mysql \
        php7-pdo_sqlite \
        php7-phar \
        php7-posix \
        php7-session \
        php7-sockets \
        php7-xdebug \
        php7-zlib \
    && rm -rf /var/cache/apk/* \
    && ln -s /usr/bin/php7 /usr/local/bin/php \
    && echo "clear_env = no" >> /etc/php7/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && adduser -SDHu 1000 php \
    && sed -i "s/user *=.*$/user = php/" /etc/php7/php-fpm.conf \
    && mkdir -p /srv \
    && printf "<?php phpinfo(); ?>" > /srv/index.php

# install caddy
RUN wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" | tar xvz caddy \
    && mv /caddy /usr/local/bin/caddy

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]
