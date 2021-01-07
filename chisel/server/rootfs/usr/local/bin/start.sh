#!/bin/sh

envsubst '$PORT' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf || exit 1

exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf

