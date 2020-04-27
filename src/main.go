package main

import (
	"log"
	"net/http"
	"os"

	"github.com/kwcay/boateng-api/src/graph"
	"github.com/kwcay/boateng-api/src/router"
)

// Build-time variables
var version string
var gitHash string

func main() {
	router := router.Create()
	port := os.Getenv("BOATENG_API_PORT")

	if port == "" {
		port = "80"
	}

	graph.RefreshSchema()

	log.Println("Environment: " + os.Getenv("BOATENG_ENV"))
	log.Println("Version: " + version)
	log.Println("Hash: " + gitHash)
	log.Printf("Dora Boateng API: http://localhost:%s", port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}
