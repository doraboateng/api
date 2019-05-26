#!/usr/bin/env bash

./scripts/setup.sh

# Load environment variables.
# shellcheck disable=SC1091
set -a; source .env; set +a;

# Show container logs.
CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $CONTAINER_ID == "" ]]; then
    echo "No container running."
else
    docker container logs "$CONTAINER_ID" --follow --tail 10
fi
