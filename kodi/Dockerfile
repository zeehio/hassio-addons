# Helper image to build kodi
FROM alpine:edge

RUN apk add --no-cache alpine-sdk sudo

COPY aports-kodi/ /aports-kodi
WORKDIR /aports-kodi/

RUN adduser --disabled-password apkbuilder \
  && addgroup apkbuilder abuild \
  && addgroup apkbuilder sudo \
  && mkdir -p /var/cache/distfiles \
  && chmod a+w /var/cache/distfiles

USER apkbuilder

RUN abuild-keygen -a -i -n

RUN abuild -r

RUN ls ~/packages


ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache \
         mesa \
         mesa-dri-gallium \
         kodi \
         kodi-gbm

RUN apk add kmscube --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

COPY rootfs /

# Default KODI HTTP port
EXPOSE 8080

# Labels
LABEL maintainer="Sergio Oller"
