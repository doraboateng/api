package router

import (
	"time"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/cors"
	"github.com/go-chi/render"
)

// Create sets up the router and middleware, and defines all API routes.
func Create() *chi.Mux {
	// Create new router.
	router := chi.NewRouter()

	// Register middlewares.
	router.Use(
		middleware.RedirectSlashes,
		middleware.Logger,
		middleware.Recoverer,
		middleware.Compress(5),
		render.SetContentType(render.ContentTypeJSON),
		cors.New(GetCorsOptions()).Handler,
	)

	// Set a timeout value on the request context (ctx), that will signal
	// through ctx.Done() that the request has timed out and further
	// processing should be stopped.
	router.Use(middleware.Timeout(60 * time.Second))

	// Informational routes
	router.Get("/", GetHealth)
	router.Get("/health", GetHealth)
	router.Get("/ping", GetPing)

	// GraphQL.
	// router.Post("/graphql", GraphHandler)
	// router.Post("/refresh-schema", RefreshSchemaHandler)

	// Search routes
	router.Get("/search", SearchHandler)

	return router
}
