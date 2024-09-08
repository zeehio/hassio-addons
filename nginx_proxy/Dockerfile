ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache nginx openssl curl

# Copy data
COPY rootfs /

WORKDIR /
