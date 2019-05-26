#!/usr/bin/env bash

./scripts/setup.sh
./scripts/start.sh --quiet

# Load environment variables.
# shellcheck disable=SC1091
set -a
source ./.env
set +a

# Run all tests.
CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $CONTAINER_ID == "" ]]; then
    echo "No container running. Use the \"./run\" script to launch it."
else
    docker exec --interactive --tty "$CONTAINER_ID" bash -c "go test -cover ./..."
fi
