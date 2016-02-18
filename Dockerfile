FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV HOME=/root

# install packages
RUN apk --update --no-progress add openssl \
	&& rm -rf /var/cache/apk/*

# install s6 supervisor
ENV S6_VERSION 1.13.0.0
RUN cd /tmp \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz \
    && tar xzf s6-overlay-amd64.tar.gz -C /
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
