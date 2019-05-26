#!/usr/bin/env bash

./scripts/setup.sh

# Load environment variables.
# shellcheck disable=SC1091
set -a
source ./.env
set +a

# Launch the API.
docker-compose up --detach

# Check container status.
sleep 1
RUNNING=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $RUNNING == "" ]]; then
    echo "Could not launch container. Dumping latest logs..."
    CONTAINER_ID=$(docker container ls -a | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
    docker container logs "$CONTAINER_ID" --tail 10

    echo ""
    echo "Run \"docker container logs $CONTAINER_ID\" to see more logs."
    exit 1
fi

if [[ $1 != "--quiet" ]]; then
    echo ""
    echo "Running container ID: $RUNNING"
    echo "You can view the logs from the API by running \"./run logs\"."
    echo "To stop the API, use \"./run stop\"."
fi
