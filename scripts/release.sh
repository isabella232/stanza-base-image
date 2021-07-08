#!/usr/bin/env bash

set -e

IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"
echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/
docker tag "${IMAGE}" "gcr.io/observiq-container-images/${IMAGE}"
docker push "${IMAGE_NAME}:${IMAGE_TAG}"