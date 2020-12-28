#!/usr/bin/env bashio

cd /app

export INGRESS_ENTRYPOINT=$(bashio::addon.ingress_entry)
exec /usr/bin/python3 ./app.py
