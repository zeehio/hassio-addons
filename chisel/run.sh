#!/usr/bin/env bashio
set +u


CONFIG_PATH=/data/options.json
SYSTEM_USER=/data/system_user.json

CHISEL_SERVER=$(bashio::config 'chisel_server')
CHISEL_R_HOST=$(bashio::config 'chisel_remote_host')
CHISEL_R_PORT=$(bashio::config 'chisel_remote_port')
FINGERPRINT=$(bashio::config 'fingerprint')
CHISEL_USER=$(bashio::config 'chisel_user')
CHISEL_PASSWORD=$(bashio::config 'chisel_password')
KEEPALIVE=$(bashio::config 'keepalive')
MAX_RETRY_COUNT=$(bashio::config 'max_retry_count')

exec /usr/local/bin/chisel client \
   --fingerprint "${FINGERPRINT}" \
   --auth "${CHISEL_USER}:${CHISEL_PASSWORD}" \
   --keepalive "${KEEPALIVE}" \
   --max-retry-count "${MAX_RETRY_COUNT}" \
   "${CHISEL_SERVER}" \
       "R:${CHISEL_R_HOST}:${CHISEL_R_PORT}:homeassistant:8123"
