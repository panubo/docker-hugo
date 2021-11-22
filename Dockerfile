FROM docker.io/alpine:3.14

ENV \
  HUGO_VERSION=0.89.4 \
  HUGO_CHECKSUM=88bcff016b16974909615bafc6e89a95f44999576034893e32ef1f1a2124af46

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
