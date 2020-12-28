#!/usr/bin/env bashio

cd /app

export INGRESS_URL=$(bashio::addon.ingress_url)
exec /usr/bin/python3 ./app.py
