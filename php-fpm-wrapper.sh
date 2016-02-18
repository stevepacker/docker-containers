#!/usr/bin/env sh

if [ ! -z "$PHP_BEFORE" ]; then
    eval $PHP_BEFORE
fi

if [ -f /srv/composer.lock ]; then
    cd /srv
    composer install ${PHP_COMPOSER_FLAGS}
fi

php-fpm

if [ ! -z "$PHP_AFTER" ]; then
    eval $PHP_AFTER
fi