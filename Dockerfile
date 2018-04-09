FROM docker.io/alpine:3.7

ENV \
  HUGO_VERSION=0.37.1 \
  HUGO_CHECKSUM=f7b57c4d9e406719e41c84a4a70d6b332826bf356a15615ed02a450134796f81

RUN set -x \
  && apk add --no-cache ca-certificates wget \
  && cd /tmp \
  && wget -nv https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && echo "${HUGO_CHECKSUM}  hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" > /tmp/SHA256SUM \
  && sha256sum -c SHA256SUM \
  && tar -zxf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
  && mv hugo /usr/local/bin/hugo \
  && apk del wget \
  && rm -rf /tmp/* \
  ;
