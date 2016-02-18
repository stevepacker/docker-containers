# Caddy Server with PHP-FPM

This creates a Docker container running PHP on Alpine Linux.

## Why another container?  

I just wanted all the PHP libraries I tend to use.  Consider
this the kitchen-sink version of the parent container by abiosoft.

It also supports running commands before and after starting PHP-FPM and running 
`composer install` before running PHP-FPM.

## Run Example

- `docker run -p 80:80 -p 443:443 -v /var/www/html:/srv stevepacker/caddy-php`


## Docker Environment Variables

- `PHP_BEFORE`: command(s) to run prior to running `composer install` and `php-fpm`
- `PHP_COMPOSER_FLAGS`: flags to include with `composer install` (ex: --prefer-dist --no-dev)
- `PHP_AFTER`: command(s) to run after `composer install` and `php-fpm`

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
- php-fpm 
- php-cli 
- php-curl 
- php-gd 
- php-json 
- php-iconv 
- php-mcrypt 
- php-intl 
- php-ctype
- php-pdo_mysql 
- php-pdo_sqlite 
- php-posix 
- php-sockets 
- php-imap 
- php-openssl
- php-phar