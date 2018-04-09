FROM docker.io/alpine:3.7

ENV \
  HUGO_VERSION=0.38.1 \
  HUGO_CHECKSUM=13b6dac57078f658faf6d07eebfb2d801a6a3a8949e3f30818562821f23569ac

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

WORKDIR /hugo
ENTRYPOINT ["hugo"]
