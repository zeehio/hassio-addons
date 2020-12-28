#!/usr/bin/env bashio

echo "env:"
env


INGRESS_ENTRYPOINT=$(bashio::addon.ingress_entry)
INGRESS_URL=$(bashio::addon.ingress_url)

echo "env again:"
env
cd /app

exec /usr/bin/python3 app.py
