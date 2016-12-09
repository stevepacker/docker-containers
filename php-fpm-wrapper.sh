#!/usr/bin/env sh

if [ ! -z "$PHP_BEFORE" ]; then
    eval $PHP_BEFORE
fi

if [ -f /srv/composer.lock ]; then
    cd /srv
    composer install ${PHP_COMPOSER_FLAGS}
fi

/usr/local/sbin/php-fpm -c /usr/local/etc/php/ --fpm-config /usr/local/etc/php-fpm.conf --nodaemonize --force-stderr

if [ ! -z "$PHP_AFTER" ]; then
    eval $PHP_AFTER
fi
