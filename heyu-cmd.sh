#!/bin/sh

cp -a /etc/heyu.default/x10.sched.sample /etc/heyu/x10.sched.sample
cp -a /etc/heyu.default/x10config.sample /etc/heyu/x10config.sample

heyu engine     2>&1 &
heyu upload     2>&1 &
heyu setclock   2>&1 &
heyu monitor    2>&1 &

cd /app
php -S0.0.0.0:80 index.php