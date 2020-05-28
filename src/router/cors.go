package router

import (
	"os"

	"github.com/go-chi/cors"
)

// GetCorsOptions returns the CORS options for the API based on the environment.
func GetCorsOptions() cors.Options {
	allowedOrigins := []string{"https://www.doraboateng.com"}

	if os.Getenv("BOATENG_ENV") == "local" {
		allowedOrigins = []string{
			"http://localhost:*",
			"http://0.0.0.0:*",
			"http://127.0.0.1:*",
			"http://172.21.0.0/24:*",
		}
	}

	return cors.Options{
		AllowedOrigins:   allowedOrigins,
		AllowedMethods:   []string{"GET", "POST", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type", "X-CSRF-Token"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300, // Maximum value not ignored by any of major browsers
		Debug:            os.Getenv("APP_ENV") == "local",
	}
}
