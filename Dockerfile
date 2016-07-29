FROM phusion/baseimage:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
	&& apt-get update \
	&& apt-get install -y git \
		php7.0-bcmath \
		php7.0-cli \
		php7.0-curl \
		php7.0-fpm \
		php7.0-gd \
		php7.0-intl \
		php7.0-json \
		php7.0-mbstring \
		php7.0-mcrypt \
		php7.0-mysql \
		php7.0-xml \
		php7.0-zip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# New Relic
#
RUN export DLFILE=$(curl https://download.newrelic.com/php_agent/release/ | awk -F\" '/linux.tar.gz/ { print $2 }') \
    && echo "Downloading: $DLFILE" \
    && curl -L "http://download.newrelic.com/php_agent/release/${DLFILE}" > newrelic-php5.tar.gz \
    && tar xfz newrelic-php5.tar.gz \
    && cd newrelic-* \
    && NR_INSTALL_USE_CP_NOT_LN=1 NR_INSTALL_SILENT=1 ./newrelic-install install \
    && rm -Rf /tmp/newrelic

ENV  NEWRELIC_LICENSE= \
     NEWRELIC_APPNAME=

#
# Composer
#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
# Caddy
#
RUN mkdir -p /tmp/caddy \
    && curl -L "http://caddyserver.com/download/build?os=linux&arch=amd64&features=git,ipfilter,jwt,realip" > /tmp/caddy/caddy.tar.gz \
    && cd /tmp/caddy \
    && tar xfz caddy.tar.gz \
    && mv caddy /usr/local/bin/caddy \
    && rm -Rf /tmp/caddy

COPY Caddyfile /etc/Caddyfile
COPY php-fpm-wrapper.sh /usr/local/bin/php-fpm-wrapper

ENV PHP_BEFORE= \
    PHP_AFTER= \
    PHP_COMPOSER_FLAGS=

VOLUME ["/root/.caddy", "/srv"]

CMD ["/usr/local/bin/caddy", "-conf=/etc/Caddyfile", "-agree"]

#
# Unprivileged User
#
RUN adduser --system --no-create-home --uid=1000 --disabled-password --disabled-login php \
	&& sed -i "s/user *=.*$/user = php/" /etc/php/7.0/fpm/php-fpm.conf \
	&& echo "clear_env = no" >> /etc/php/7.0/fpm/php-fpm.conf \
	&& mkdir -p /srv \
	&& printf "<?php phpinfo(); ?>" > /srv/index.php
