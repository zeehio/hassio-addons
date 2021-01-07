FROM alpine:3.12

WORKDIR /app

RUN apk add curl nginx supervisor bash gettext \
  && curl https://i.jpillora.com/chisel! | bash

ENV AUTH=
ENV CHISEL_KEY=

CMD ["/usr/local/bin/start.sh"]

COPY rootfs /

RUN mkdir -p /app/logs/ \
  && mkdir -p /app/logs/nginx/ \
  && chmod -R 776 /app/logs/ \
  && mkdir -p /var/lib/nginx/ \
  && chmod -R 776 /var/lib/nginx/

