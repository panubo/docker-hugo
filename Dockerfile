FROM docker.io/alpine:3.12

ENV \
  HUGO_VERSION=0.75.1 \
  HUGO_CHECKSUM=98e157dc2eda1f78b19959ff45c8a750abd6ae12330fad6574b466efdb58bd1d

RUN set -x \
  && apk add --no-cache ca-certificates bash wget make git myrepos openssh-client coreutils \
  && cd /tmp \
  && wget -nv https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && echo "${HUGO_CHECKSUM}  hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM || ( echo "Expected $(sha256sum hugo_${HUGO_VERSION}_Linux-64bit.tar.gz)"; exit 1; )) \
  && tar -zxf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && mv hugo /usr/local/bin/hugo \
  && apk del wget \
  && rm -rf /tmp/* \
  ;

RUN set -x \
  && mkdir -p /hugo \
  ;

WORKDIR /hugo
