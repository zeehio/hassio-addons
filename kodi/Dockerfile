# Helper image to build kodi
ARG BUILD_FROM
FROM $BUILD_FROM AS builder

RUN apk add --no-cache alpine-sdk sudo \
  && echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel

RUN adduser --disabled-password -h /home/apkbuilder apkbuilder \
  && addgroup apkbuilder abuild \
  && addgroup apkbuilder wheel \
  && mkdir -p /var/cache/distfiles \
  && chmod a+w /var/cache/distfiles

RUN apk update


COPY aports-kodi/ /aports-kodi
WORKDIR /aports-kodi/
RUN chown -R apkbuilder /aports-kodi

RUN abuild-keygen -a -i -n

USER apkbuilder

RUN HOME=/home/apkbuilder abuild-keygen -a -n

RUN HOME=/home/apkbuilder abuild -r

RUN ls ~/packages

RUN rm /etc/sudoers.d/wheel


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
