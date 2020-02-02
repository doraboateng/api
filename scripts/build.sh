#!/bin/sh

# Exit on error
set -e

. scripts/utils.sh

VERSION=$1
IMAGE_NAME="doraboateng/api-bin"
GIT_HASH=$(git rev-parse --short HEAD)

if [ "$VERSION" = "" ]; then
    VERSION=$(git describe --abbrev=0 --tags)
fi

BUILD_NAME="build-$VERSION"

if image_exists "$IMAGE_NAME:$VERSION"; then
    docker image rm --force "$IMAGE_NAME:$VERSION"
fi

docker build \
    --build-arg VERSION="$VERSION" \
    --build-arg BUILD_NAME="$BUILD_NAME" \
    --build-arg GIT_HASH="$GIT_HASH" \
    --force-rm \
    --tag "$IMAGE_NAME:$VERSION" \
    .

echo ""
echo "Publish build to Docker registry? [no]"
read -r RESPONSE

if [ "$RESPONSE" = "yes" ]; then
    get_env DOCKER_HUB_TOKEN | docker login \
        --username "$(get_env DOCKER_HUB_USERNAME)" \
        --password-stdin

    docker push "$IMAGE_NAME:$VERSION"
fi

echo ""
echo "Pruning Docker resources..."
echo ""

docker system prune
