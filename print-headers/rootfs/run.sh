#!/usr/bin/env bashio

cd /app

export INGRESS_ENTRYPOINT=$(bashio::addon.ingress_entry)
export INGRESS_URL=$(bashio::addon.ingress_url)

env
exec /usr/bin/python3 ./app.py
