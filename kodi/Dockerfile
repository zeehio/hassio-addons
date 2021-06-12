# Helper image to build kodi
FROM alpine:edge

RUN apk add --no-cache alpine-sdk

COPY aports-kodi/ /aports-kodi
WORKDIR /aports-kodi/

RUN adduser apkbuilder \
  && addgroup apkbuilder abuild \
  && mkdir -p /var/cache/distfiles \
  && chmod a+w /var/cache/distfiles

USER apkbuilder

RUN abuild package


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
