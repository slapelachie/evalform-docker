#!/bin/sh
exec /usr/bin/supervisord -c /etc/supervisord.conf

# Start PHP-FPM in the background
# php-fpm &

# Start Nginx in the foreground
# nginx -g 'daemon off;'