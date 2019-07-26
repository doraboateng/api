#!/bin/sh

get_version() {
    VERSION=$(sed -n -e 's/LABEL version="\(.*\)"/\1/p' Dockerfile)

    if [ "$VERSION" = "" ]; then
        echo "Could not retrieve version from Dockerfile."
        echo "Make sure a \"version\" label is specified and try again."
        
        return 1
    else
        echo "$VERSION"

        return 0
    fi
}

image_exists() {
    if [ "$(docker images --quiet $1)" = "" ]; then
        return 1
    fi

    return 0
}
