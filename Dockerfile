FROM stevepacker/caddy-php7
MAINTAINER Stephen Packer <steve@stevepacker.com>

RUN mkdir -p /tmp/newrelic \
    && cd /tmp/newrelic \
    && export DLFILE=$(curl https://download.newrelic.com/php_agent/release/ | awk -F\" '/linux-musl.tar.gz/ { print $2 }') \
    && echo "Downloading: $DLFILE" \
    && wget "http://download.newrelic.com/php_agent/release/${DLFILE}" \
    && tar xfz newrelic-php5-*.tar.gz \
    && cd newrelic-php5-* \
    && NR_INSTALL_USE_CP_NOT_LN=1 NR_INSTALL_SILENT=1 ./newrelic-install install \
    && rm -Rf /tmp/newrelic

RUN php -v

ENV  NEWRELIC_LICENSE= \
     NEWRELIC_APPNAME=

COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper
