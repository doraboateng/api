#!/usr/bin/env bash

./scripts/start.sh --quiet

set -a
source .env
set +a

DOCKER_CONTAINER_ID=$(docker container ls | grep "${COMPOSE_PROJECT_NAME}_api" | cut -c 1-12)
if [[ $DOCKER_CONTAINER_ID == "" ]]; then
    echo "Could not launch container."
    exit 1
else
    # Export dependencies to file.
    EXPORT_FILE="dependencies.txt"
    docker exec --interactive --tty "$DOCKER_CONTAINER_ID" bash \
        -c "go list -f '{{ join .Imports \"\\n\" }}' > $EXPORT_FILE"
    mv --force "./src/$EXPORT_FILE" "./$EXPORT_FILE"

    echo "Package list saved to \"./$EXPORT_FILE\""
fi
