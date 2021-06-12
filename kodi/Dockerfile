# Helper image to build kodi
ARG BUILD_FROM
FROM $BUILD_FROM AS builder

RUN apk add --no-cache \
  build-base curl hicolor-icon-theme \
  py3-bluez py3-pillow py3-simplejson \
  python3 xdpyinfo curl-dev ffmpeg-dev \
  flatbuffers-dev fmt-dev freetype-dev \
  fribidi-dev fstrcmp-dev giflib-dev glu-dev \
  gtest-dev libass-dev libcdio-dev libdrm-dev \
  libdvdcss-dev libdvdnav-dev libdvdread-dev \
  libjpeg-turbo-dev lzo-dev mesa-dev openssl-dev \
  pcre-dev rapidjson-dev spdlog-dev sqlite-dev \
  taglib-dev tinyxml-dev zlib-dev libxkbcommon-dev \
  waylandpp-dev libinput-dev alsa-lib-dev \
  avahi-dev bluez-dev dav1d-dev dbus-dev \
  eudev-dev libbluray-dev libcap-dev \
  libcec-dev \
  libmicrohttpd-dev libnfs-dev libplist-dev \
  libshairport-dev libva-glx-dev libxslt-dev \
  mariadb-connector-c-dev pulseaudio-dev \
  python3-dev samba-dev autoconf automake cmake \
  doxygen graphviz libtool openjdk8-jre-base \
  swig tar wayland-protocols xz

WORKDIR /build

RUN wget "https://github.com/xbmc/xbmc/archive/19.1-Matrix.tar.gz" \
  && wget "https://mirrors.kodi.tv/build-deps/sources/crossguid-8f399e8bd4.tar.gz" \
  && echo "downloaded"

RUN echo "extracting sources" \
  && tar xzf 19.1-Matrix.tar.gz \
  && tar xzf crossguid-8f399e8bd4.tar.gz

#crossguid-8f399e8bd4
#/build/xbmc-19.1-Matrix

#	fix-musl-incompability.patch
#	sse-build.patch
#	kodi.initd
#	60-kodi.rules


RUN echo "Building Kodi" \
  && export LDFLAGS="$LDFLAGS -Wl,-z,stack-size=1048576" \
  && cd "/build/xbmc-19.1-Matrix" \
  && make -C tools/depends/target/crossguid PREFIX="/opt/kodi"


#builddir="$srcdir/xbmc-$pkgver-$_realname"

RUN apk add --no-cache alpine-sdk sudo \
  && echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel

RUN adduser --disabled-password -h /home/apkbuilder apkbuilder \
  && addgroup apkbuilder abuild \
  && addgroup apkbuilder wheel \
  && mkdir -p /var/cache/distfiles \
  && chmod a+w /var/cache/distfiles \
  && rm -rf /var/cache/apk \
  && mkdir -p /var/cache/apk \
  && ln -s /var/cache/apk /etc/apk/cache

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
