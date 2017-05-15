FROM alpine:3.5

LABEL architecture="amd64"

ARG plugins=dns,hook.service,http.awslambda,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.git,http.hugo,http.ipfilter,http.jwt,http.mailout,http.minify,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.upload,net,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dnsimple,tls.dns.dnspod,tls.dns.dyn,tls.dns.exoscale,tls.dns.gandi,tls.dns.googlecloud,tls.dns.linode,tls.dns.namecheap,tls.dns.ovh,tls.dns.rackspace,tls.dns.rfc2136,tls.dns.route53,tls.dns.vultr

RUN apk add --no-cache openssh-client git tar curl \
  && curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && echo "0.0.0.0\nbrowse\nlog stdout\nerrors stdout" > /etc/Caddyfile \
 && /usr/bin/caddy -version

EXPOSE 80 443
VOLUME /root/.caddy
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
