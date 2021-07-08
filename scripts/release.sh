#!/usr/bin/env bash

set -e

echo "${GCLOUD_SERVICE_KEY}" | docker login -u _json_key --password-stdin https://gcr.io/
docker push "${IMAGE_NAME}:${IMAGE_TAG}"