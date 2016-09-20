FROM alpine:3.4
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV HEYU_VERSION=2.11-rc1

# Adapted from https://github.com/kevineye/docker-heyu/blob/master/Dockerfile
RUN apk --no-cache add tini curl build-base php5-cli \
 && mkdir /build \
 && cd /build \
 && curl -L https://github.com/HeyuX10Automation/heyu/archive/v${HEYU_VERSION}.tar.gz | tar xz \
 && cd heyu-* \
 && ./configure --sysconfdir=/etc \
 && make \
 && make install \
 && apk --purge del curl build-base \
 && rm -rf /build /etc/ssl /var/cache/apk/* /lib/apk/db/*

RUN cp -r /etc/heyu /etc/heyu.default \
 && mkdir -p /usr/local/var/tmp/heyu \
 && mkdir -p /usr/local/var/lock \
 && chmod 777 /usr/local/var/tmp/heyu \
 && chmod 777 /usr/local/var/lock \
 && mkdir -p /app

VOLUME /etc/heyu
EXPOSE 80

COPY heyu-cmd.sh /usr/local/bin/heyu-cmd.sh
COPY index.php /app/index.php

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["heyu-cmd.sh"]
