FROM stevepacker/caddy-php7
MAINTAINER Stephen Packer <steve@stevepacker.com>

# install php and other libraries
RUN apk add --update php7-xdebug