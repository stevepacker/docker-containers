FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

RUN apk -U add openrc zoneminder mysql mysql-client php5-fpm php5-pdo_mysql lighttpd \
    && rm -rf /var/cache/apk/*

COPY  mysql_setup.sh /mysql_setup.sh

RUN mkdir -p /run/openrc \
    && touch /run/openrc/softlevel \
    && mkdir -p /var/log/zoneminder/ \
    && touch /var/log/zoneminder/web_php.log \
    && chown lighttpd /etc/zm.conf /var/log/zoneminder/web_php.log /var/lib/zoneminder/images /var/lib/zoneminder/events \
    && sed -i 's/nobody/lighttpd/' /etc/php5/php-fpm.conf \
    && sed -i 's/apache/lighttpd/' /etc/zm.conf \
    && sed -i 's/ZM_DB_HOST=localhost/ZM_DB_HOST=127.0.0.1/' /etc/zm.conf \
    && sed -i 's/^#   include "mod_cgi.conf"/include "mod_cgi.conf"/' /etc/lighttpd/lighttpd.conf \
    && sed -i 's/^#   include "mod_fastcgi_fpm.conf"/include "mod_fastcgi_fpm.conf"/' /etc/lighttpd/lighttpd.conf \
    && /mysql_setup.sh

COPY run.sh /run.sh
CMD  ["/run.sh"]

