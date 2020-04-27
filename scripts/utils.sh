#!/bin/sh

get_env() {
    ENV_NAME=$1
    [ "$ENV_NAME" = "" ] && return 1

    ./scripts/create-env.sh

    set -a
    . .env
    set +a

    eval "ENV_VALUE=\$$ENV_NAME"
    echo "$ENV_VALUE"

    return 0
}

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
        echo "No container running for service \"${SERVICE_NAME}\"."
        return 1
    else
        echo "$CONTAINER_ID"
        return 0
    fi
}

image_exists() {
    IMAGE_ID=$(docker images --quiet "$1")

    if [ "$IMAGE_ID" = "" ]; then
        return 1
    fi

    return 0
}
