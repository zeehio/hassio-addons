ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache \
         mesa \
         mesa-dri-gallium

RUN apk add --no-cache \
  alsa-lib avahi-libs bluez-libs busybox dbus-libs eudev-libs \
  ffmpeg-libs fmt freetype fribidi libass libbluray libcap libcdio \
  libcrypto1.1 libcurl libdrm libgcc libinput-libs libmicrohttpd libnfs \
  libpcrecpp libplist libpulse libsmbclient libstdc++ libuuid libva libxkbcommon \
  libxml2 libxslt lzo mariadb-connector-c mesa-egl mesa-gbm mesa-gles musl \
  pcre python3 sqlite-libs taglib tinyxml zlib fstrcmp libcec

RUN apk add kmscube --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN cd / \
 && wget https://github.com/zeehio/my-kodi-binaries/releases/download/v19.1-0-cec/kodi-built-with-libcec.tgz \
 && tar xzf kodi-built-with-libcec.tgz \
 && rm kodi-built-with-libcec.tgz

COPY rootfs /

# Default KODI HTTP port
EXPOSE 8080

# Labels
LABEL maintainer="Sergio Oller"
