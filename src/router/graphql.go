package router

import (
	"net/http"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/kwcay/boateng-api/src/graph"
	"github.com/kwcay/boateng-api/src/graph/generated"
	"github.com/kwcay/boateng-api/src/graph/resolvers"
	"github.com/kwcay/boateng-graph-service/src/dgraph"
)

// GraphHandler handles all incoming GraphQL requests.
func GraphHandler(writer http.ResponseWriter, request *http.Request) {
	client, closeConn := graph.GetClient()
	defer closeConn()

	schema := generated.NewExecutableSchema(generated.Config{
		Resolvers: &resolvers.Resolver{
			Dgraph: client,
		},
		Directives: generated.DirectiveRoot{},
		Complexity: generated.ComplexityRoot{},
	})

	server := handler.NewDefaultServer(schema)

	// TODO: read up on complexity...
	// "github.com/99designs/gqlgen/graphql/handler/extension"
	// server.Use(extension.FixedComplexityLimit(300))

	server.ServeHTTP(writer, request)
}

// RefreshSchemaHandler ...
func RefreshSchemaHandler(writer http.ResponseWriter, request *http.Request) {
	client, closeConn := dgraph.GetClient()
	defer closeConn()

	graph.LoadSchema(client)

	writer.Write([]byte(""))
}
