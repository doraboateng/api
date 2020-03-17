#!/bin/sh

# Make sure DB container exists.
DB_ID=$(docker container ls --all --quiet --filter name=boateng_db)
if [ "$DB_ID" = "" ]; then
    docker-compose --project-name boateng up --no-start db

    echo "The database service needs some time to start. Try again in a minute."
    exit 0
fi

./scripts/start.sh --quiet
. scripts/utils.sh

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
