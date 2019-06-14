package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/doraboateng/api/src/router"
	"github.com/go-chi/chi"
)

// API version.
var version string

// Git hash corresponding to the currently running build.
var	gitHash string

func main() {
	router := router.Create()

	// List available routes.
	walkFunc := func(method string, route string, handler http.Handler, middlewares ...func(http.Handler) http.Handler) error {
		log.Printf("%s %s\n", method, route)

		return nil
	}

	log.Println("Available routes:")

	if err := chi.Walk(router, walkFunc); err != nil {
		log.Panicf("Logging error: %s\n", err.Error())
	}

	// Launch server
	port := os.Getenv("APP_PORT")

	if port == "" {
		port = "8008"
	}

	fmt.Println("Environment: " + os.Getenv("APP_ENV"))
	fmt.Println("Version: " + version)
	fmt.Println("Hash: " + gitHash)
	fmt.Println("Serving API on http://localhost:" + port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}
