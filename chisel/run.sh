#!/usr/bin/env bashio
set +u

CONFIG_PATH=/data/options.json
SYSTEM_USER=/data/system_user.json

HA_HOST="$(jq --raw-output '.ha_host' $CONFIG_PATH)"
HA_PORT="$(jq --raw-output '.ha_port' $CONFIG_PATH)"
CHISEL_SERVER="$(jq --raw-output '.chisel_server' $CONFIG_PATH)"
CHISEL_R_HOST="$(jq --raw-output '.chisel_remote_host $CONFIG_PATH)"
CHISEL_R_PORT="$(jq --raw-output '.chisel_remote_port' $CONFIG_PATH)"
FINGERPRINT="$(jq --raw-output '.fingerprint' $CONFIG_PATH)"
CHISEL_USER="$(jq --raw-output '.chisel_user' $CONFIG_PATH)"
CHISEL_PASSWORD="$(jq --raw-output '.chisel_password' $CONFIG_PATH)"
KEEPALIVE="$(jq --raw-output '.keepalive' $CONFIG_PATH)"
MAX_RETRY_COUNT="$(jq --raw-output '.max-retry-count' $CONFIG_PATH)"

# FIXME: try to set  hahost to homeassistant and haport to 8123 and then drop host network.

exec chisel client \
   --fingerprint "${FINGERPRINT}" \
   --auth "${CHISEL_USER}:${CHISEL_PASSWORD}" \
   --keepalive "${KEEPALIVE}" \
   --max-retry-count "${MAX_RETRY_COUNT}" \
   "${CHISEL_SERVER}" \
       "R:${CHISEL_R_HOST}:${CHISEL_R_PORT}:${HA_HOST}:${HA_PORT}"