#!/bin/sh

# Exit on error
set -e

echo ""
echo "This will drop all data in the graph. Continue? (yes/[no])"
read -r DROP_DATA

if [ "$DROP_DATA" = "yes" ]; then
    echo "TODO"
    echo ""
fi

echo ""
echo "Drop the schema as well? (yes/[no])"
read -r DROP_SCHEMA

if [ "$DROP_SCHEMA" = "yes" ]; then
    curl localhost:8080/alter --data-binary '{ "drop_all": true }'
    echo ""
fi

echo "Done."
