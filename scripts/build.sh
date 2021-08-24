#!/usr/bin/env bash

set -e

echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag gcr.io/observiq-container-images/stanza-base:$(git rev-parse --short HEAD) \
    --build-arg dependencies="$(jq -r 'to_entries | .[] | .key + "=" + .value' dependencies.json)" \
    --push \
    .