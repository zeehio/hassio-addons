ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache \
         python3 \
         py3-flask

COPY rootfs /

# Labels
LABEL maintainer="Sergio Oller"
