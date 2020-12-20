ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN (curl https://i.jpillora.com/chisel@v1.7.3! | bash)

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
