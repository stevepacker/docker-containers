FROM stevepacker/caddy-php7
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV NEWRELIC_VERSION=6.4.0.163

RUN mkdir -p /tmp/newrelic \
    && cd /tmp/newrelic \
    && wget "http://download.newrelic.com/php_agent/release/newrelic-php5-${NEWRELIC_VERSION}-linux.tar.gz" \
    && tar xfz newrelic-php5-*.tar.gz \
    && cd newrelic-php5-* \
    && ./newrelic-install install \
    && rm -Rf /tmp/newrelic

ENV  NEWRELIC_LICENSE= \
     NEWRELIC_APPNAME=

COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

