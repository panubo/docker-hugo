FROM docker.io/alpine:3.9

ENV \
  HUGO_VERSION=0.54.0 \
  HUGO_CHECKSUM=76f90287c12a682c9137b85146c406be410b2b30b0df7367f02ee7c4142bb416

RUN set -x \
  && APP_NAME=hugo \
  && apk add --no-cache ca-certificates wget make git myrepos \
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
