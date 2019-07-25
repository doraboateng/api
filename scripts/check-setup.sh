#!/bin/sh

# Create environment file if needed.
if [ ! -f .env ]; then
    cp .env.example .env
fi
