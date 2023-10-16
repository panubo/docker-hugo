# Hugo Extended Version needs glibc, therefore use Debian base.

FROM docker.io/debian:12

ENV \
  HUGO_VERSION=0.119.0 \
  HUGO_CHECKSUM_X86_64=5d6f222cb6a81a6e08e8f60bdc66d714cc30118e12bf91fa07eb70083653d730 \
  HUGO_CHECKSUM_AARCH64=cce066c6c83c3c08a2ab37b43b8a876c529384bf7fa7af87540e8cb940837fba

RUN export DEBIAN_FRONTEND=noninteractive \
  && set -x \
  && apt-get update \
  && apt-get -y install ca-certificates bash wget make git myrepos openssh-client coreutils rsync python3-docutils \
  && if [ "$(uname -m)" = "x86_64" ] ; then \
        HUGO_CHECKSUM="${HUGO_CHECKSUM_X86_64}"; \
        HUGO_ARCH="amd64"; \
      elif [ "$(uname -m)" = "aarch64" ]; then \
        HUGO_CHECKSUM="${HUGO_CHECKSUM_AARCH64}"; \
        HUGO_ARCH="arm64"; \
      fi \
  && cd /tmp \
  && wget -nv https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz \
  && echo "${HUGO_CHECKSUM}  hugo_extended_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz" > /tmp/SHA256SUM \
  && ( cd /tmp; sha256sum -c SHA256SUM || ( echo "Expected $(sha256sum hugo_extended_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz)"; exit 1; )) \
  && tar -zxf hugo_extended_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz \
  && mv hugo /usr/local/bin/hugo \
  && apt-get -y remove wget \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  ;

RUN set -x \
  && mkdir -p /hugo \
  ;

WORKDIR /hugo
