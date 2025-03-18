#!bin/sh

/usr/sbin/php-fpm7 -d variables_order="EGPCS"

nginx -g "daemon off;"
