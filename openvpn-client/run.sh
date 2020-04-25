mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi

jq --raw-output '.config' /data/options.json > /openvpn.conf
jq --raw-output '.key' /data/options.json > /openvpn.key

	jq --raw-output '.user' /data/options.json > /user_pass.conf
jq --raw-output '.password' /data/options.json >> /user_pass.conf

openvpn --secret /openvpn.key --config /openvpn.conf
