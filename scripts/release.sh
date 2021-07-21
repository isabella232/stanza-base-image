#!/usr/bin/env bash

set -e

if [ -z "$IMAGE_TAG" ]
then
      echo "${IMAGE_TAG} not set, skipping release"
fi

IMAGE="${IMAGE_NAME}:${IMAGE_TAG}"
echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/
docker tag "${IMAGE_NAME}:latest" "${IMAGE}"
docker tag "${IMAGE}" "gcr.io/observiq-container-images/${IMAGE}"
docker push "gcr.io/observiq-container-images/${IMAGE}"