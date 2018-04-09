#!/usr/bin/env bash
# Update the Dockerfile to use the latest release and associated checksum

json="$(curl -sSf https://api.github.com/repos/gohugoio/hugo/releases/latest)"

latest="$(echo "${json}" | jq -r .tag_name)"

echo "Latest: ${latest#v}"

# Get the checksums
# echo "${json}"  | jq '.assets[] | select(.browser_download_url | contains("checksums.txt"))'

# Get the github assets
# echo "${json}" | jq '.assets[] | select(.browser_download_url | contains("Linux-64bit.tar.gz"))'
