FROM docker.io/alpine:3.9

ENV \
  HUGO_VERSION=0.57.2 \
  HUGO_CHECKSUM=558cd6d492562cf7bc2a24a683cdc2608043a4f593077442480944cc7c1f8665

RUN set -x \
  && APP_NAME=hugo \
  && apk add --no-cache ca-certificates bash wget make git myrepos openssh-client coreutils \
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
