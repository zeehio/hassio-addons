OpenVPN instance

Forked from https://github.com/TheSkorm/hassio-openvpn

Plugin addon looks like this
```
{
  "config": "dev tun\nifconfig 10.1.0.2 10.1.0.1\nport 1194\ncomp-lzo\nping 15\nping-restart 45\nping-timer-rem\nremote server.domaname\nverb 3\n",
  "key": "#\n# 2048 bit OpenVPN static key\n#\n-----BEGIN OpenVPN Static key V1-----\n\n-----END OpenVPN Static key V1-----\n",
  "user": "theusername",
  "password": "s3cr3t"
}
```

The user and password are saved to /user_pass.conf. Include this line in your config file:

    auth-user-pass /user_pass.conf

