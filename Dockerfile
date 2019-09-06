FROM docker.io/alpine:3.9

ENV \
  HUGO_VERSION=0.58.0 \
  HUGO_CHECKSUM=073f692b7523d5bdf415273d4b8b26f5c230b57c36fe719368e7027368b9c5b7

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
