FROM docker.io/alpine:3.18

ENV \
  HUGO_VERSION=0.119.0 \
  HUGO_CHECKSUM_X86_64=c94f12d589a0b3c8955cf5107ccc6e9e89ab5a901fb5eb1de1c889da844b737f \
  HUGO_CHECKSUM_AARCH64=f7b15f01ca227243b80f022de919ce7921bac21de588048af15bbfe56907a4d2

RUN set -x \
  && apk add --no-cache ca-certificates bash wget make git myrepos openssh-client coreutils rsync py3-docutils \
  && if [ "$(uname -m)" = "x86_64" ] ; then \
        HUGO_CHECKSUM="${HUGO_CHECKSUM_X86_64}"; \
        HUGO_ARCH="amd64"; \
      elif [ "$(uname -m)" = "aarch64" ]; then \
        HUGO_CHECKSUM="${HUGO_CHECKSUM_AARCH64}"; \
        HUGO_ARCH="arm64"; \
      fi \
  && cd /tmp \
  && wget -nv https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz \
  && echo "${HUGO_CHECKSUM}  hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM || ( echo "Expected $(sha256sum hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz)"; exit 1; )) \
  && tar -zxf hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz \
  && mv hugo /usr/local/bin/hugo \
  && apk del wget \
  && rm -rf /tmp/* \
  ;

RUN set -x \
  && mkdir -p /hugo \
  ;

WORKDIR /hugo
