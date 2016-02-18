FROM alpine:3.3
MAINTAINER Stephen Packer <steve@stevepacker.com>

LABEL caddy_version="0.8.1" \
      architecture="amd64"

EXPOSE 80 443

# install php and other libraries
RUN apk add --update openssl git tar curl \
        php-fpm php-cli php-curl php-gd php-json php-iconv php-mcrypt php-intl php-ctype \
        php-pdo_mysql php-pdo_sqlite php-posix php-sockets php-imap php-openssl php-phar \
    && rm -rf /var/cache/apk/* \
    && echo "clear_env = no" >> /etc/php/php-fpm.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && adduser -SDHu 1000 php \
    && sed -i "s/user *=.*$/user = php/" /etc/php/php-fpm.conf \
    && mkdir -p /srv \
    && printf "<?php phpinfo(); ?>" > /srv/index.php

# install caddy
RUN wget -O - "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter" | tar xvz caddy \
    && mv /caddy /usr/local/bin/caddy

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]