FROM docker.io/alpine:3.7

ENV \
  HUGO_VERSION=0.53 \
  HUGO_CHECKSUM=0e4424c90ce5c7a0c0f7ad24a558dd0c2f1500256023f6e3c0004f57a20ee119

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
