ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add python3 py3-flask

WORKDIR /app/
# Copy data for add-on
COPY app.py /app/
#COPY uwsgi.ini /app/uwsgi.ini

CMD [ "/usr/bin/python", "app.py" ]

