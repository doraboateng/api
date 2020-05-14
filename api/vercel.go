package handler

import (
	"net/http"

	"github.com/kwcay/boateng-api/src/router"
)

// Handler for Vercel serverless function.
func Handler(writer http.ResponseWriter, request *http.Request) {
	router.GraphHandler(writer, request)
}
