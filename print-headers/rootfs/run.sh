#!/usr/bin/env bashio

cd /app

echo $(bashio::addon.url)

exec /usr/bin/python3 ./app.py
