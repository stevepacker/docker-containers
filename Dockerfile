FROM alpine:3.2
MAINTAINER Stephen Packer <steve@stevepacker.com>

WORKDIR /app
VOLUME ["/app"]

RUN apk -U add nodejs openssl \
    && rm -rf /var/cache/apk/* \
    && npm install -g supervisor nodemon \
    && adduser -D -u 1000 node \
    && chown -Rf node /app

# install s6 supervisor
ENV S6_VERSION 1.17.1.1
RUN cd /tmp \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz \
    && tar xzf s6-overlay-amd64.tar.gz -C /
ENTRYPOINT ["/init"]

COPY apk-install.sh /etc/cont-init.d/10-apk-install
COPY jit_init.sh    /etc/cont-init.d/20-jit-init
COPY npm-install.sh /etc/cont-init.d/50-npm-install
