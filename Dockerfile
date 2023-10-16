FROM docker.io/alpine:3.18

ENV \
  HUGO_VERSION=0.119.0 \
  HUGO_CHECKSUM=c94f12d589a0b3c8955cf5107ccc6e9e89ab5a901fb5eb1de1c889da844b737f

RUN set -x \
  && apk add --no-cache ca-certificates bash wget make git myrepos openssh-client coreutils rsync py3-docutils \
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
