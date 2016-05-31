FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV HOME=/root

# install packages
RUN apk --update --no-progress add openssl \
	&& rm -rf /var/cache/apk/*

# This creates a directory, which is not right.  But you should "docker run -v" this file.
COPY sample-log_files.yml /etc/papertrail.yml

ENV PAPERTRAIL_VERSION 0.17
ENV PAPERTRAIL_URL https://github.com/papertrail/remote_syslog2/releases/download/v$PAPERTRAIL_VERSION/remote_syslog_linux_amd64.tar.gz
RUN cd /tmp \
    && wget -O - $PAPERTRAIL_URL | tar xz \
    && mv remote_syslog/remote_syslog /usr/local/bin \
    && rm -Rf remote_syslog

CMD ["/usr/local/bin/remote_syslog", "--no-detach", "--configfile=/etc/papertrail.yml"]
