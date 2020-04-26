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

echo "#!/bin/bash" > /vpn-up.sh
echo "set -e" >> /vpn-up.sh
jq --raw-output '.up | join("\n")' /data/options.json >> /vpn-up.sh
chmod a+x /vpn-up.sh

echo "#!/bin/bash" > /vpn-down.sh
echo "set -e" >> /vpn-down.sh
jq --raw-output '.down | join("\n")' /data/options.json >> /vpn-down.sh
chmod a+x /vpn-down.sh

key_size=$(wc -c < /openvpn.key)
secret_cmd=
if [ $key_size -ge 2 ]; then
  secret_cmd="--secret /openvpn.key"
fi

openvpn ${secret_cmd} --script-security 2  --config /openvpn.conf
