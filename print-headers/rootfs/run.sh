#!/usr/bin/env bashio

cd /app

INGRESS_ENTRYPOINT=$(bashio::addon.ingress_entry)
INGRESS_URL=$(bashio::addon.ingress_url)

env

echo $(bashio::addon.url)

exec /usr/bin/python3 ./app.py
