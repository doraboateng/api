#!/usr/bin/env bash

# Create environment file if needed.
if [ ! -f ./.env ]; then
    cp .env.example .env
fi

# Load environment file.
set -a
source ./.env
set +a
