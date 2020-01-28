ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk add --no-cache jq;\
    apk add   --no-cache --virtual .build-deps git go;\
	export GOPATH=/opt/go; \
	go get -v github.com/jpillora/chisel;\
	mv /opt/go/bin/chisel /bin/chisel;\
	apk del .build-deps ;\
	rm -rf /opt/go

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]