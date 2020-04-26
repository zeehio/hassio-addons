#!/bin/bash
set -e

mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi

jq --raw-output '.config | join("\n")' /data/options.json > /openvpn.conf
jq --raw-output '.key' /data/options.json > /openvpn.key

jq --raw-output '.user' /data/options.json > /user_pass.conf
jq --raw-output '.password' /data/options.json >> /user_pass.conf

key_size=$(wc -c < /openvpn.key)
secret_cmd=
if [ $key_size -ge 2 ]; then
  secret_cmd="--secret /openvpn.key"
fi

sysctl net.ipv4.ip_forward

#iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
#iptables -A FORWARD -i tun0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -i wlan0 -o tun0 -j ACCEPT

openvpn ${secret_cmd} --config /openvpn.conf
