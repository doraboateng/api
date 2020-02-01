#!/bin/sh

./scripts/create-env.sh
./scripts/check-docker-image.sh

set -a
. .env
set +a

docker-compose up --detach

# Check container status.
sleep 1
CONTAINER_ID=$(docker container ls --filter name="boateng_api" --quiet)
if [[ $CONTAINER_ID == "" ]]; then
    echo "Could not launch container. Dumping latest logs..."
    CONTAINER_ID=$(docker container ls --all --filter name="boateng_api" --quiet)
    docker container logs "$CONTAINER_ID" --tail 10

    echo ""
    echo "Run \"docker container logs $CONTAINER_ID\" to see more logs."
    exit 1
fi

if [[ $1 != "--quiet" ]]; then
    echo ""
    echo "You can view the logs from the API by running \"./run logs\"."
    echo "To stop the API, use \"./run stop\"."
    echo "Docker container: $CONTAINER_ID"
fi
