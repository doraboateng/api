package main

import (
	"log"
	"net/http"
	"os"

	"github.com/doraboateng/api/src/router"
	"github.com/doraboateng/api/src/utils"
)

// Build-time variables
var version string
var gitHash string

func main() {
	// Bootstap API.
	utils.SetupSentry(version)

	// Setup router and serve API.
	router := router.Create()
	port := os.Getenv("PORT")

	if port == "" {
		port = "80"
	}

	log.Println("Environment: " + os.Getenv("BOATENG_ENV"))
	log.Println("Version: " + version)
	log.Println("Hash: " + gitHash)
	log.Printf("Service API at: http://localhost:%s", port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}
