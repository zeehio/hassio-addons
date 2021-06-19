ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
RUN mkdir -p "/etc/apt/sources.list.d/" \
  && echo 'deb http://deb.debian.org/debian buster-backports main' > /etc/apt/sources.list.d/backports.list

RUN apt-get update && apt-get install -y kodi

COPY rootfs /

# Default KODI HTTP port
EXPOSE 8080

# Labels
LABEL maintainer="Sergio Oller"
