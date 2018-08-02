FROM docker.io/alpine:3.7

ENV \
  HUGO_VERSION=0.46 \
  HUGO_CHECKSUM=96c431b1b76aed4833739966235098162b97ca9933e1ff2bcd09f7571842ea6b

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
