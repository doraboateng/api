#!/usr/bin/env bash

./scripts/start.sh --quiet

DOCKER_CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $DOCKER_CONTAINER_ID == "" ]]; then
    exit 1
fi

docker exec \
    --interactive \
    --tty \
    "$DOCKER_CONTAINER_ID" \
    bash -c "gofmt -d ."
