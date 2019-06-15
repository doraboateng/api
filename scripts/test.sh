#!/usr/bin/env bash

./scripts/setup.sh
./scripts/start.sh --quiet

set -a
source .env
set +a

DOCKER_CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)

if [[ $DOCKER_CONTAINER_ID == "" ]]; then
    echo "No container running. Use the \"./run\" script to launch it."
else
    docker exec --interactive --tty "$DOCKER_CONTAINER_ID" bash -c "go test -cover ./..."
fi
