#!/usr/bin/env sh

if [ ! -z "$PHP_BEFORE" ]; then
    eval $PHP_BEFORE
fi

if [ -f /srv/composer.lock ]; then
    cd /srv
    composer install ${PHP_COMPOSER_FLAGS}
fi

if [ ! -z "$NEWRELIC_LICENSE" ]; then
    echo "Inserting newrelic license: $NEWRELIC_LICENSE"
    sed -i "s/newrelic.license\s*=.*$/newrelic.license = \"$NEWRELIC_LICENSE\"/" /etc/php7/conf.d/newrelic.ini
fi
if [ ! -z "$NEWRELIC_APPNAME" ]; then
    echo "Inserting newrelic appname: $NEWRELIC_APPNAME"
    sed -i "s/newrelic.appname\s*=.*$/newrelic.appname = \"$NEWRELIC_APPNAME\"/" /etc/php7/conf.d/newrelic.ini
fi

php-fpm7

if [ ! -z "$PHP_AFTER" ]; then
    eval $PHP_AFTER
fi
