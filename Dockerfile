FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>
EXPOSE 137 138 139 445

ENV HOME=/root

# install packages
RUN apk --update --no-progress add samba openssl \
	&& rm -rf /var/cache/apk/*

# install s6 supervisor
ENV S6_VERSION 1.13.0.0
RUN cd /tmp \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-amd64.tar.gz \
    && tar xzf s6-overlay-amd64.tar.gz -C /
CMD ["/init"]

COPY samba.s6 /etc/services.d/samba/run
RUN  ln -s /dev/stdout /var/log/samba/log

VOLUME ["/data"]
