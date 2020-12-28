ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add python3 py3-flask

# Copy data for add-on
COPY rootfs /
WORKDIR /app/

CMD [ "/run.sh" ]

