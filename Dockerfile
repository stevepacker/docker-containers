FROM alpine:3.2
MAINTAINER Stephen Packer <steve@stevepacker.com>

# Add packages, and create an "app" user to own application files, and prep to allow
# a private SSH key to be mounted to assist in git-clone over SSH
RUN apk -U add git openssl openssh less \
    && rm -rf /var/cache/apk/* \
    && adduser -Du 1000 -h /home/app app \
    && mkdir -p /home/app/.ssh /app \
    && chmod 0700 /home/app/.ssh \
    && chown app /home/app/.ssh /app

USER app
WORKDIR /app
VOLUME ["/app"]
ENTRYPOINT ["/entrypoint.sh"]
COPY entrypoint.sh /entrypoint.sh

# Don't validate SSH Host
ENV GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" \
    GIT_BRANCH="master"

