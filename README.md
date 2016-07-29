# Caddy Server with PHP-FPM

[![](https://badge.imagelayers.io/stevepacker/caddy-php:latest.svg)](https://imagelayers.io/?images=stevepacker/caddy-php:latest 'Get your own badge on imagelayers.io')

This creates a Docker container running PHP on phusion/baseimage.

## Why another container?  

I just wanted all the PHP libraries I tend to use.  Consider
this the kitchen-sink version of the parent container by abiosoft.

It also supports running commands before and after starting PHP-FPM and running 
`composer install` before running PHP-FPM.

## Run Example

- `docker run -p 80:80 -p 443:443 -v /var/www/html:/srv stevepacker/caddy-php7-newrelic`

## Docker Environment Variables

- `PHP_BEFORE`: command(s) to run prior to running `composer install` and `php-fpm`
- `PHP_COMPOSER_FLAGS`: flags to include with `composer install` (ex: --prefer-dist --no-dev)
- `PHP_AFTER`: command(s) to run after `composer install` and `php-fpm`
- `NEWRELIC_LICENSE`: license string as provided by New Relic
- `NEWRELIC_APPNAME`: name this application should be labeled as in New Relic
## Docker Volumes

- `/srv`: Base directory.  If a `composer.lock` is in this directory, 
    `composer install` will automatically run prior to starting `php-fpm`
- `/root/.caddy`: When an SSL is generated, files are stored here by Caddy.
- `/etc/Caddyfile`: If you intend to include your own Caddyfile, mount it here.

## Caddy Extensions:

- git
- ipfilter

## PHP Extensions:

- composer
- php7-fpm
- ... and a bunch of others.  Read the Dockerfile.
