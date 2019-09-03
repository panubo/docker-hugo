#!/usr/bin/env bash
# Update the Dockerfile to use the latest release and associated checksum

set -e

FILE_SUFIX="Linux-64bit.tar.gz"
LATEST_URL="https://api.github.com/repos/gohugoio/hugo/releases/latest"

[[ "$(uname -s)" == "Darwin" ]] && SED="gsed" || SED='sed'

json="$(curl -sSf "${LATEST_URL}")"

latest="$(echo "${json}" | jq -r .tag_name)"
echo "Latest: ${latest#v}"

# Get the checksums
checksums_url="$(echo "${json}"  | jq -r '.assets[] | select(.name | contains("hugo_extended") | not) | select(.name | contains("checksums.txt")) | .browser_download_url')"
checksum="$(curl -sSfL "${checksums_url}" | ${SED} -E -e "/hugo_${latest#v}_${FILE_SUFIX}/!d" -e 's/([0-9a-f]+) .*/\1/')"
echo "Checksum: ${checksum}"

${SED} -i -E -e "s/HUGO_VERSION=[0-9\\.]*/HUGO_VERSION=${latest#v}/" -e "s/HUGO_CHECKSUM=[0-9a-f]*/HUGO_CHECKSUM=${checksum}/" Dockerfile

# Get the github assets
# echo "${json}" | jq '.assets[] | select(.browser_download_url | contains("Linux-64bit.tar.gz"))'
