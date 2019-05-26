#!/usr/bin/env bash

# Create environment file if needed.
if [ ! -f ./.env ]; then
    cp .env.example .env
fi
