FROM alpine:3.4
MAINTAINER Stephen Packer <steve@stevepacker.com>

RUN apk -U --no-cache add iptables ppp pptpd \
    && rm -rf /var/cache/apk/* 
    
EXPOSE 1723

COPY pptpd.sh      /
COPY pptpd.conf    /etc/
COPY pptpd-options /etc/ppp/

CMD ["/pptpd.sh"]

ENV USERNAMES= \
    PASSWORDS=


