#!/bin/sh

# Exit on error
set -e

echo ""
echo "This will drop all data in the graph. Continue? (yes/[no])"
read -r DROP_DATA

if [ "$DROP_DATA" = "yes" ]; then
    echo "TODO: this only works with Slash GraphQL."

    curl localhost:8080/admin/slash \
        --header "Content-Type: application/graphql" \
        --data-binary "mutation { dropData(allData: true) { response { code message } } }"
    echo ""
fi

echo ""
echo "Drop the schema as well? (yes/[no])"
read -r DROP_SCHEMA

if [ "$DROP_SCHEMA" = "yes" ]; then
    echo "TODO: this only works with Slash GraphQL."

    curl localhost:8080/admin/slash \
        --header "Content-Type: application/graphql" \
        --data-binary "mutation { dropData(allDataAndSchema: true) { response { code message } } }"
    echo ""
fi

echo "Done."
