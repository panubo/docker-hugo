FROM docker.io/alpine:3.12

ENV \
  HUGO_VERSION=0.80.0 \
  HUGO_CHECKSUM=b3a259bbe633e2f9182f8ecfc1b5cee6a7cfc4c970defe5f29c9959f2ef3259b

RUN set -x \
  && apk add --no-cache ca-certificates bash wget make git myrepos openssh-client coreutils rsync \
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
