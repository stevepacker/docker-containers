FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV HOME=/root

# install packages
RUN apk --update --no-progress add openssl \
	&& rm -rf /var/cache/apk/*

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

COPY remote_syslog.s6 /etc/services.d/remote_syslog/run

# This creates a directory, which is not right.  But you should "docker run -v" this file.
#VOLUME ["/etc/log_files.yml"]

ENV PAPERTRAIL_VERSION 0.14
ENV PAPERTRAIL_URL https://github.com/papertrail/remote_syslog2/releases/download/v$PAPERTRAIL_VERSION/remote_syslog_linux_amd64.tar.gz
RUN cd /tmp \
    && wget $PAPERTRAIL_URL \
    && tar xfz remote_syslog_linux_amd64.tar.gz \
    && mv remote_syslog/remote_syslog /usr/local/bin \
    && rm -Rf remote_syslog_linux_amd64.tar.gz remote_syslog
