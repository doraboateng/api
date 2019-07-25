#!/bin/sh

. scripts/utils.sh

if ! IMAGE_VERSION=$(get_version); then
    echo "$IMAGE_VERSION"
    exit 1
fi

# Check if image has already been built.
REPOSITORY_NAME="doraboateng/api-build"
if image_exists "$REPOSITORY_NAME:$IMAGE_VERSION"; then
    exit 0
fi

if ! docker build --tag "$REPOSITORY_NAME:$IMAGE_VERSION" .
then
    exit 1
fi

if image_exists "$REPOSITORY_NAME:latest"; then
    docker image rm --force "$REPOSITORY_NAME:latest"
fi

docker tag "$REPOSITORY_NAME:$IMAGE_VERSION" "$REPOSITORY_NAME:latest"
