#!/usr/bin/env bash

RESET_ENV=$1
if [ "$RESET_ENV" = "reset" ]; then
    rm ./.env
fi

if [ ! -f ./.env ]; then
    echo "Creating environment file..."
    touch ./.env

    {
        echo "# App"
        echo "APP_ENV=local"
        echo "APP_PORT=8008"

        echo ""
        echo "# Docker variables"
        echo "COMPOSE_PROJECT_NAME=boateng"

        echo ""
        echo "# MariaDB"
        echo "MARIADB_USERNAME=boateng_dev"
        echo "MARIADB_PASSWORD=boateng_dev"
        echo "MARIADB_DATABASE=boateng_dev"
        echo "MARIADB_HOST=db"
        echo "MARIADB_PORT=3306"
        echo "MARIADB_HOST_PORT=13306"
    } >> ./.env

    echo "Done!"
fi
