#!/bin/sh

MSG_NO_RUNNING_CONTAINER="No container running. Use the \"./run\" script to launch it."

get_container_id() {
    SERVICE_NAME=$1
    if [ "$SERVICE_NAME" = "" ]; then
        SERVICE_NAME="api"
    fi

    set -a
    . .env
    set +a

    CONTAINER_ID=$(docker container ls --quiet --filter name="${COMPOSE_PROJECT_NAME}_${SERVICE_NAME}")
    if [ "$CONTAINER_ID" = "" ]; then
        echo "$MSG_NO_RUNNING_CONTAINER"
        return 1
    else
        echo "$CONTAINER_ID"
        return 0
    fi
}

get_version() {
    VERSION=$(sed -n -e 's/LABEL version="\(.*\)"/\1/p' Dockerfile)

    if [ "$VERSION" = "" ]; then
        echo "Could not retrieve version from Dockerfile."
        echo "Make sure a \"version\" label is specified and try again."
        
        return 1
    else
        echo "$VERSION"

        return 0
    fi
}

image_exists() {
    if [ "$(docker images --quiet $1)" = "" ]; then
        return 1
    fi

    return 0
}
