package graph

import (
	"bytes"
	"context"
	"io/ioutil"
	"log"
	"net/http"
	"os"

	"github.com/dgraph-io/dgo/v200"
	"github.com/dgraph-io/dgo/v200/protos/api"
	"google.golang.org/grpc"
	"google.golang.org/grpc/encoding/gzip"
)

// GetClient connects to all Dgraph Alpha instances.
func GetClient() *dgo.Dgraph {
	var conn *grpc.ClientConn
	var err error
	graphEndpoint := os.Getenv("GRAPH_ENDPOINT")

	if slashKey := os.Getenv("SLASH_GRAPHQL_AUTH_TOKEN"); slashKey != "" {
		log.Println("Connecting to Slash GraphQL backend")
		conn, err = dgo.DialSlashEndpoint(graphEndpoint, slashKey)
	} else {
		conn, err = grpc.Dial(
			graphEndpoint,
			grpc.WithInsecure(),
			grpc.WithDefaultCallOptions(grpc.UseCompressor(gzip.Name)),
		)
	}

	if err != nil {
		log.Fatal("While trying to dial gRPC")
	}

	defer conn.Close()
	alpha1 := api.NewDgraphClient(conn)
	client := dgo.NewDgraphClient(alpha1)

	return client
}

// LoadSchema updates the Dgraph schema and indices.
// TODO: deprecated.
func LoadSchema(client *dgo.Dgraph) error {
	log.Println("Refreshing Graph schema...")

	schemaByteStr, err := readFile("GRAPH_SCHEMA_PATH", "graph.gql")
	if err != nil {
		return err
	}

	indicesByteStr, err := readFile("GRAPH_INDICES_PATH", "indices.dgraph")
	if err != nil {
		return err
	}

	_, err = http.Post(
		"http://alpha:8080/admin/schema",
		"text/plain",
		bytes.NewBuffer(schemaByteStr),
	)

	if err != nil {
		return err
	}

	err = client.Alter(context.Background(), &api.Operation{
		RunInBackground: true,
		Schema:          string(indicesByteStr),
	})

	if err != nil {
		return err
	}

	return err
}

// RefreshSchema ...
// TODO: deprecated.
func RefreshSchema() {
	client := GetClient()

	LoadSchema(client)
}

// TODO: deprecated.
func readFile(envKey string, filename string) ([]byte, error) {
	filepath := "./src/graph/schema/" + filename

	if envFilePath, ok := os.LookupEnv(envKey); ok {
		filepath = envFilePath
	}

	byteStr, err := ioutil.ReadFile(filepath)

	if err != nil {
		return nil, err
	}

	return byteStr, nil
}
