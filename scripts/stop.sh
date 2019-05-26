#!/usr/bin/env bash

./scripts/setup.sh

# Load environment variables.
# shellcheck disable=SC1091
set -a
source ./.env
set +a

# Stop the container.
if [[ $1 != "--quiet" ]]; then
    echo "Stopping container..."
fi

CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $CONTAINER_ID != "" ]]; then
    docker stop "$CONTAINER_ID" > /dev/null
fi
