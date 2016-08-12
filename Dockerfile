FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

# install packages and remote_syslog
RUN apk --no-cache --no-progress add openssl ca-certificates tini \
        && export PAPERTRAIL_PATH=$(wget -O - https://github.com/papertrail/remote_syslog2/releases 2>/dev/null | awk -F\" '/_linux_amd64.tar.gz/ { print $2 }' | head -1) \
        && wget -O - "https://github.com/$PAPERTRAIL_PATH" | tar xz \
        && chown -Rf root:root remote_syslog \
        && mv remote_syslog/remote_syslog /usr/local/bin \
        && mv remote_syslog/example_config.yml /etc/papertrail.yml \
        && rm -Rf remote_syslog

# use [Tini](https://github.com/krallin/tini) as init system 
# for reaping zombies and performing signal forwarding
ENTRYPOINT ["/sbin/tini", "--"]

# run remote_syslog in foreground
CMD ["/usr/local/bin/remote_syslog", "--no-detach", "--configfile=/etc/papertrail.yml"]

