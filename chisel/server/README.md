# Reverse proxy behind firewall

This repository is meant to be used as a heroku app.

It will allow you to access a web service running in your LAN (such as on a raspberry pi)
from the internet without port forwarding.


## Server: Running on Heroku

Supervisor monitors two processes: nginx and a chisel server.

`nginx` faces heroku and listens to whatever `PORT` heroku specifies (as an env variable). 
It forwards all requests to a service that would be listening at `127.0.0.1:8125`. The
only exception is the `/.chisel` endpoint that is forwarded to `127.0.0.1:8124`.

A `chisel` server listens on `localhost:8124` allowing for reverse port mapping. It requires
`AUTH` and `CHISEL_KEY` environment variables to be set.


### Submitting this app to heroku:

Set required environment variables on heroku. Please see the [chisel](https://github.com/jpillora/chisel)
documentation to generate suitable values.

- AUTH
- CHISEL_KEY


Build the docker image from this repo and push it:

    heroku container:push web

Deploy:

    heroku container:release web

See the Logs:

    heroku logs --tail


## Client: Running at home

Let's say you have a server running at home, in your LAN. For instance on a raspberry pi
listening at `192.168.0.34:8800`.

Install [chisel](https://github.com/jpillora/chisel) in your home system and run:

```
LAN_HOST=192.168.0.34
LAN_PORT=8800
CHISEL_SERVER="https://your-heroku-app.com/.chisel"
# The user and password should be accepted by AUTH in the server
CHISEL_USER=
CHISEL_PASSWORD=
# The fingerprint should be the public key for the CHISEL_KEY
FINGERPRINT=

# You don't need to change this:
MAX_RETRY_COUNT=30
KEEPALIVE="30s"
CHISEL_R_HOST=127.0.0.1
CHISEL_R_PORT=8124
chisel client \
   --fingerprint "${FINGERPRINT}" \
   --auth "${CHISEL_USER}:${CHISEL_PASSWORD}" \
   --keepalive "${KEEPALIVE}" \
   --max-retry-count "${MAX_RETRY_COUNT}" \
   "${CHISEL_SERVER}" \
       "R:${CHISEL_R_HOST}:${CHISEL_R_PORT}:${LAN_HOST}:${LAN_PORT}"
```

Once the server and client sides are running, you should be able to browse your local
web by visiting `https://your-heroku-app.com/`.



