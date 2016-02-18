FROM alpine:3.2
MAINTAINER Stephen Packer <steve@stevepacker.com>

WORKDIR /app
VOLUME ["/app"]

RUN apk -U add nodejs openssl \
    && rm -rf /var/cache/apk/* \
    && npm install -g supervisor nodemon \
    && adduser -D -u 1000 node \
    && chown -Rf node /app

# install s6 supervisor, verifying its authenticity via instructions at:
# https://github.com/just-containers/s6-overlay#verifying-downloads
ENV S6_VERSION 1.17.1.2
RUN cd /tmp \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz.sig \
    && apk --update --no-progress add --virtual gpg gnupg \
    && gpg --keyserver pgp.mit.edu --recv-key 0x337EE704693C17EF \
    && gpg --verify /tmp/s6-overlay-amd64.tar.gz.sig /tmp/s6-overlay-amd64.tar.gz \
    && tar xzf s6-overlay-amd64.tar.gz -C / \
    && apk del gpg \
    && rm -rf /tmp/s6-overlay-amd64.tar.gz /tmp/s6-overlay-amd64.tar.gz.sig /root/.gnupg /var/cache/apk/*
CMD ["/init"]

COPY apk-install.sh /etc/cont-init.d/10-apk-install
COPY jit_init.sh    /etc/cont-init.d/20-jit-init
COPY npm-install.sh /etc/cont-init.d/50-npm-install
