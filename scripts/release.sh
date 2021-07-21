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
docker tag "${IMAGE_NAME}:latest" "${IMAGE}"
docker tag "${IMAGE}" "gcr.io/observiq-container-images/${IMAGE}"
docker push "gcr.io/observiq-container-images/${IMAGE}"