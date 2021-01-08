#!/bin/sh

# Exit on error
set -e

. scripts/utils.sh

GRAPH_REPO="doraboateng/graph"
PROJECT_DIR="$(pwd)"
SAMPLE_TMP_DIR="$PROJECT_DIR/tmp/data/$(date +'%Y-%m-%d')"

rm -rf "$SAMPLE_TMP_DIR"
mkdir -p "$SAMPLE_TMP_DIR"

echo ""
echo "Downloading graph schema from $GRAPH_REPO..."
curl \
    "https://raw.githubusercontent.com/$GRAPH_REPO/stable/src/schema/graph.gql" \
    --output "$SAMPLE_TMP_DIR/graph.gql"
curl \
    "https://raw.githubusercontent.com/$GRAPH_REPO/stable/src/schema/indices.dgraph" \
    --output "$SAMPLE_TMP_DIR/indices.dgraph"

echo ""
echo "Retrieving sample data..."
cp assets/sample.rdf.tar.gz "$SAMPLE_TMP_DIR/rdf.tar.gz"
cd "$SAMPLE_TMP_DIR"
tar --extract --gzip --file rdf.tar.gz
cp export/**/* .
cd "$PROJECT_DIR"

echo ""
echo "Loading schema into graph..."
curl localhost:8080/admin/schema --data-binary "@$SAMPLE_TMP_DIR/graph.gql" && echo ""
curl localhost:8080/alter --data-binary "@$SAMPLE_TMP_DIR/indices.dgraph" && echo ""

echo ""
echo "Loading sample data into graph..."
docker run \
    --interactive \
    --rm \
    --network boateng_api_shared_network \
    --tty \
    --volume "$SAMPLE_TMP_DIR:/tmp" \
    dgraph/dgraph:"$(get_env DGRAPH_VERSION)" \
    dgraph live \
        --alpha alpha:9080 \
        --files /tmp/g01.rdf.gz \
        --zero zero:5080

echo ""
echo "Cleaning temporary files..."
rm -rf "$SAMPLE_TMP_DIR"

echo ""
echo "Done."
