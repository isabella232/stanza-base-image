#!/usr/bin/env bash

set -e

if echo "${IMAGE_TAG}" | grep '\(merge\|pull\|master\)'
then
    echo "image tag not set, skipping release"
    exit 0
fi

IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"

echo "using image ${IMAGE}"

echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag "gcr.io/observiq-container-images/${IMAGE}" \
    --push \
    .