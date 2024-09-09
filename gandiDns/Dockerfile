ARG BUILD_FROM
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

COPY updater.sh /
RUN chmod a+x /updater.sh

CMD ["/updater.sh"]