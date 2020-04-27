#!/bin/sh

. scripts/utils.sh

SERVICE_NAME=$1
if [ "$SERVICE_NAME" = "" ]; then
    SERVICE_NAME="api"
fi

if ! CONTAINER_ID=$(get_container_id $SERVICE_NAME); then
    echo "$CONTAINER_ID"
    exit 1
fi

echo "Launching shell in \"$SERVICE_NAME\" container..."

docker exec --interactive --tty "$CONTAINER_ID" bash
