#!/usr/bin/env sh

if [ ! -z "$PHP_BEFORE" ]; then
    eval $PHP_BEFORE
fi

if [ -f /srv/composer.lock ]; then
    cd /srv
    composer install ${PHP_COMPOSER_FLAGS}
fi

sed -i "s/^listen = .*$/listen = 127.0.0.1:9000/" /etc/php/7.0/fpm/pool.d/www.conf
sed -i "s/;extension=php_pdo_mysql.so/extension=php_pdo_mysql.so/" /etc/php/7.0/fpm/php.ini
sed -i "s/;extension=php_pdo_mysql.so/extension=php_pdo_mysql.so/" /etc/php/7.0/cli/php.ini

mkdir -p /run/php

if [ ! -z "$NEWRELIC_LICENSE" ]; then
    echo "Inserting newrelic license: $NEWRELIC_LICENSE"
    sed -i "s/newrelic.license\s*=.*$/newrelic.license = \"$NEWRELIC_LICENSE\"/" /etc/php/7.0/cli/conf.d/newrelic.ini
    sed -i "s/newrelic.license\s*=.*$/newrelic.license = \"$NEWRELIC_LICENSE\"/" /etc/php/7.0/fpm/conf.d/newrelic.ini
fi
if [ ! -z "$NEWRELIC_APPNAME" ]; then
    echo "Inserting newrelic appname: $NEWRELIC_APPNAME"
    sed -i "s/newrelic.appname\s*=.*$/newrelic.appname = \"$NEWRELIC_APPNAME\"/" /etc/php/7.0/cli/conf.d/newrelic.ini
    sed -i "s/newrelic.appname\s*=.*$/newrelic.appname = \"$NEWRELIC_APPNAME\"/" /etc/php/7.0/fpm/conf.d/newrelic.ini
fi

php-fpm7.0

if [ ! -z "$PHP_AFTER" ]; then
    eval $PHP_AFTER
fi
