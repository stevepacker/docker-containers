FROM jenkins:2.0-alpine
USER root

RUN apk -U --no-cache add docker \
    && rm -rf /var/cache/apk/* \
    && addgroup jenkins docker \
    && addgroup -g 999 -S docker999 \
    && addgroup jenkins docker999

USER jenkins
