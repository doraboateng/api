#!/bin/sh

. scripts/utils.sh

if ! IMAGE_VERSION=$(get_version); then
    echo "$IMAGE_VERSION"
    exit 1
fi

IMAGE_NAME="doraboateng/api-dev"
if image_exists "$IMAGE_NAME:$IMAGE_VERSION"; then
    exit 0
fi

if ! docker build --tag "$IMAGE_NAME:$IMAGE_VERSION" --target dev .
then
    exit 1
fi

if image_exists "$IMAGE_NAME:latest"; then
    docker image rm --force "$IMAGE_NAME:latest"
fi

docker tag "$IMAGE_NAME:$IMAGE_VERSION" "$IMAGE_NAME:latest"
