#!/bin/sh

. scripts/utils.sh
./scripts/start.sh --quiet

if ! CONTAINER_ID=$(get_container_id); then
    echo "$CONTAINER_ID"
    exit 1
fi

set -a
. .env
set +a

COMMAND=$1
if [ "$COMMAND" = "" ]; then
    COMMAND="up"
fi

docker exec --interactive "$CONTAINER_ID" \
    migrate \
    -database \
        "mysql://`
        `${MARIADB_USERNAME}:${MARIADB_PASSWORD}`
        `@tcp(${MARIADB_HOST}:${MARIADB_PORT})`
        `/${MARIADB_DATABASE}" \
    -path ../migrations \
    -verbose \
    "$COMMAND"
