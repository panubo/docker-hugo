FROM docker.io/alpine:3.11

ENV \
  HUGO_VERSION=0.70.0 \
  HUGO_CHECKSUM=d0e2e1f8d2f69c1b378e34daaf9f91997cf777d3151da4d8aa6bd7b5703f9446

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
