#!/usr/bin/env bash

set -e

#echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/

TAG="$(git rev-parse --short HEAD)"

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag "gcr.io/observiq-container-images/stanza-base:${TAG}" \
    --build-arg dependencies="$(jq -r 'to_entries | .[] | .key + "=" + .value' dependencies.json | xargs)" \
    .
