FROM alpine:latest
MAINTAINER Stephen Packer <steve@stevepacker.com>

ENV HOME=/root

# install packages and create user
RUN apk --update --no-progress add git docker \
    && adduser -D -G docker build \
	&& rm -rf /var/cache/apk/*

COPY run.sh /run.sh

USER    build
WORKDIR /home/build/

CMD ["/run.sh"]