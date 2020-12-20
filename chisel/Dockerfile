ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ENV LANG C.UTF-8


RUN if [ "${BUILD_ARCH}" = "armhf" ]; then \
      URL="https://github.com/jpillora/chisel/releases/download/v1.7.3/chisel_1.7.3_linux_armv6.gz"; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
      URL="https://github.com/jpillora/chisel/releases/download/v1.7.3/chisel_1.7.3_linux_armv7.gz"; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
      URL="https://github.com/jpillora/chisel/releases/download/v1.7.3/chisel_1.7.3_linux_arm64.gz"; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
      URL="https://github.com/jpillora/chisel/releases/download/v1.7.3/chisel_1.7.3_linux_amd64.gz"; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
      URL="https://github.com/jpillora/chisel/releases/download/v1.7.3/chisel_1.7.3_linux_386.gz"; \
    else \
      echo "Unsupported build architecture: ${BUILD_ARCH}"; \
      exit 1; \
    fi; \
    curl -L $URL | gunzip > /usr/local/bin/chisel && \
    chmod +x /usr/local/bin/chisel

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
