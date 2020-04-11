#!/bin/sh

./scripts/create-env.sh
. scripts/utils.sh

# Stop the container.
if [ ! "$1" = "--quiet" ]; then
    echo "Stopping containers..."
fi

if CONTAINER_ID=$(get_container_id api); then
    docker stop "$CONTAINER_ID" > /dev/null
fi

if CONTAINER_ID=$(get_container_id db); then
    docker stop "$CONTAINER_ID" > /dev/null
fi

if CONTAINER_ID=$(get_container_id graph); then
    docker stop "$CONTAINER_ID" > /dev/null
fi
