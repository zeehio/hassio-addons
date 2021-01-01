ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# py-six is manually installed due to a missing dependency:
# https://github.com/eventable/vobject/pull/161

RUN apk add --no-cache --virtual=build-dependencies \
        gcc \
        libffi-dev \
        musl-dev \
        python3-dev \
        py-pip \
    && apk add --no-cache \
        python3 \
        tzdata \
        nginx \
        gettext \
        py-six \
    && mkdir -p /run/nginx/ \
    && python3 -m pip install --upgrade pip wheel setuptools \
    && python3 -m pip install radicale passlib[bcrypt] \
    && apk del --purge build-dependencies \
    && mkdir -p /data/ /share/radicale/

COPY rootfs /

# Labels
LABEL maintainer="Sergio Oller"
