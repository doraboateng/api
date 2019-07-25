#!/usr/bin/env bash

./scripts/check-setup.sh

set -a
source .env
set +a

DOCKER_CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $DOCKER_CONTAINER_ID == "" ]]; then
    echo "No container running."
else
    docker container logs "$DOCKER_CONTAINER_ID" --follow --tail 10
fi
