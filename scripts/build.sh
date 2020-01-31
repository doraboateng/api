#!/usr/bin/env bash

# DEPRECATED

set -a
source .env
set +a

./scripts/start.sh --quiet

DOCKER_CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)

if [[ $DOCKER_CONTAINER_ID == "" ]]; then
    exit 1
fi

BUILD_VERSION=$(git describe --abbrev=0 --tags)
BUILD_GIT_HASH=$(git rev-parse --short HEAD)
BUILD_NAME="build-$BUILD_VERSION"
LINKER_FLAGS="-X main.version=$BUILD_VERSION -X main.gitHash=$BUILD_GIT_HASH"
BUILD_COMMAND="go build -ldflags \"$LINKER_FLAGS\" -o \"$BUILD_NAME\""

docker exec \
    --interactive \
    --tty \
    "$DOCKER_CONTAINER_ID" \
    bash -c "$BUILD_COMMAND"

mv ./src/build-* ./builds/
