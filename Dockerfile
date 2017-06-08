FROM stevepacker/caddy-php71
MAINTAINER Stephen Packer <steve@stevepacker.com>

RUN apk -U add \
        chromium \
        chromium-chromedriver \
    # dependencies for PECL extensions below
        build-base \
        autoconf \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del build-base autoconf \
    && rm -rf /var/cache/apk/* \

