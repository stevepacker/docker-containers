#!/bin/sh

/etc/init.d/mariadb setup

mysqld_safe &

sleep 2

mysql -e "grant select,insert,update,delete on zm.* to 'zmuser'@'localhost' identified by 'zmpass'"
mysql < /usr/share/zoneminder/db/zm_create.sql

#killall mysqld

echo "MySQL setup done"