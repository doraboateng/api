#!/usr/bin/env bash

# Retrieve Dockerfile version
VERSION=$(sed -n -e 's/LABEL version="\(.*\)"/\1/p' Dockerfile)

if [[ $VERSION == "" ]]; then
    echo "Could not retrieve version from Dockerfile."
    echo "Make sure a \"version\" label is specified and try again."

    exit 1
fi

# Builds an image using a target in the Dockerfile.
function build-image {
    NAME=$1
    TARGET=$2

    # Check existing build images.
    IMAGE_ID=$(docker images "$NAME:$VERSION" --quiet)

    if [[ "$IMAGE_ID" != "" ]]; then
        echo ""
        read -rp "This will overwrite \"$NAME:$VERSION\". Continue? [N/y] " confirmation

        if [[ ! $confirmation =~ ^[Yy] ]]; then
            exit 0
        fi

        # Remove related container, if any.
        CONTAINER_ID=$(docker container ls -a --filter ancestor="$NAME" --format "{{.ID}}")

        if [[ "$CONTAINER_ID" != "" ]]; then
            docker container rm "$CONTAINER_ID"
        fi

        docker image rm "$NAME" "$IMAGE_ID"
    fi

    # Build the image.
    docker build \
        --force-rm \
        --tag "$NAME:latest" \
        --tag "$NAME:$VERSION" \
        --target "$TARGET" \
        .
}

# Create dependencies file.
./scripts/create-deps-file.sh
./scripts/stop.sh --quiet

# Builds images.
IMAGE_NAME=doraboateng/api
build-image "${IMAGE_NAME}-build" "build-env"
# build-image "$IMAGE_NAME" "run-env"
