#!/usr/bin/env bashio

echo "env:"
env


export INGRESS_ENTRYPOINT=$(bashio::addon.ingress_entry)
export INGRESS_URL=$(bashio::addon.ingress_url)

echo "env again:"
env
cd /app

exec /usr/bin/python3 ./app.py
