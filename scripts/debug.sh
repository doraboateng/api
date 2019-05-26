#!/usr/bin/env bash

docker run \
    --interactive \
    --rm \
    --tty \
    -v $(pwd)/src:/go/src/github.com/doraboateng/api/src \
    doraboateng/api-build:latest \
    bash
