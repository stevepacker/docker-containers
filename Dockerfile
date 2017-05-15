FROM abiosoft/caddy:latest
LABEL maintainer "Abiola Ibrahim <abiola89@gmail.com>"

ARG plugins=dns,hook.service,http.awslambda,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.git,http.hugo,http.ipfilter,http.jwt,http.mailout,http.minify,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.upload,net,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dnsimple,tls.dns.dnspod,tls.dns.dyn,tls.dns.exoscale,tls.dns.gandi,tls.dns.googlecloud,tls.dns.linode,tls.dns.namecheap,tls.dns.ovh,tls.dns.rackspace,tls.dns.rfc2136,tls.dns.route53,tls.dns.vultr

