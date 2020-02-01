#!/bin/sh

. scripts/utils.sh

if CONTAINER_ID=$(get_container_id api); then
    docker container logs "$CONTAINER_ID" --follow
else
    echo "No container running."
fi
