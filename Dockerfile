FROM docker.io/alpine:3.7

ENV \
  HUGO_VERSION=0.44 \
  HUGO_CHECKSUM=1c1d8942e12f36ef3f5ca4dd8a0a1bd9b5de87a6accc839dfbae705503e7693c

RUN set -x \
  && APP_NAME=hugo \
  && apk add --no-cache ca-certificates wget \
  && cd /tmp \
  && wget -nv https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${APP_NAME}_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && echo "${HUGO_CHECKSUM}  ${APP_NAME}_${HUGO_VERSION}_Linux-64bit.tar.gz" > /tmp/SHA256SUM \
  && sha256sum -c SHA256SUM \
  && tar -zxf ${APP_NAME}_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && mv hugo /usr/local/bin/hugo \
  && apk del wget \
  && rm -rf /tmp/* \
  ;

RUN set -x \
  && mkdir -p /hugo \
  ;

WORKDIR /hugo
