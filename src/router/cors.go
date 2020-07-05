package router

import (
	"os"

	"github.com/go-chi/cors"
)

// GetCorsOptions returns the CORS options for the API based on the environment.
func GetCorsOptions() cors.Options {
	allowedOrigins := []string{
		"https://doraboateng.com",
		"https://www.doraboateng.com",
		"http://localhost:*",
		"http://0.0.0.0:*",
		"http://10.0.0.0/8:*",
		"http://127.0.0.0/8:*",
		"http://172.16.0.0/12:*",
		"http://192.168.0.0/16:*",
	}

	return cors.Options{
		AllowedOrigins:   allowedOrigins,
		AllowedMethods:   []string{"GET", "POST", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type", "X-CSRF-Token"},
		ExposedHeaders:   []string{"Link"},
		AllowCredentials: true,
		MaxAge:           300, // Maximum value not ignored by any of major browsers
		Debug:            os.Getenv("BOATENG_ENV") == "local",
	}
}
