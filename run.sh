#!/bin/sh

mysqld_safe &
#/etc/init.d/mariadb  start

# wait for mysql to start
sleep 2

/usr/bin/zmpkg.pl start

php-fpm -D
#/etc/init.d/php-fpm  start

lighttpd -D -f /etc/lighttpd/lighttpd.conf
