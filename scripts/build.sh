#!/usr/bin/env bash

set -e

# If image tag is a version tag (v1.0.0), use it. If tag includes
# merge/pull/main, use commit hash.
if echo "${IMAGE_TAG}" | grep '\(merge\|pull\|main\)'
then
    IMAGE_TAG="$(git rev-parse --short HEAD)"
fi

echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag "gcr.io/observiq-container-images/stanza-base:${IMAGE_TAG}" \
    --build-arg dependencies="$(jq -r 'to_entries | .[] | .key + "=" + .value' dependencies.json | xargs)" \
    --push \
    .
