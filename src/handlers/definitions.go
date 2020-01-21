package handlers

import (
	"errors"
	"net/http"

	"github.com/doraboateng/api/src/utils"
	"github.com/go-chi/chi"
	"github.com/go-chi/render"
)

// --
// Structures
// --

// ---
// Router handlers
// ---

// DefinitionsHandler - handles all definition routes.
func DefinitionsHandler(r chi.Router) {
	r.With(paginate).Get("/", ListDefinitions)
	r.Post("/", CreateDefinition)
	r.Get("/search", SearchDefinitions)

	r.Route("/{id}", func(r chi.Router) {
		r.Use(DefinitionContext)
		r.Get("/", GetDefinition)
		r.Put("/", UpdateDefinition)
		r.Delete("/", DeleteDefinition)
	})

	r.With(DefinitionContext).Get("/{articleSlug:[a-z-]+}", GetDefinition)
}

// CreateDefinition ...
func CreateDefinition(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// GetDefinition ...
func GetDefinition(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// ListDefinitions ...
func ListDefinitions(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// SearchDefinitions ...
func SearchDefinitions(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// UpdateDefinition ...
func UpdateDefinition(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// DeleteDefinition ...
func DeleteDefinition(w http.ResponseWriter, r *http.Request) {
	render.Render(w, r, utils.NotImplementedError())
}

// ---
// ...
// ---

// DefinitionContext middleware is used to load an Article object from
// the URL parameters passed through as the request. In case
// the Article could not be found, we stop here and return a 404.
func DefinitionContext(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		render.Render(w, r, utils.NotFoundError(errors.New("definition not found")))
	})
}

// paginate is a stub, but very possible to implement middleware logic
// to handle the request params for handling a paginated request.
func paginate(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// just a stub.. some ideas are to look at URL query params for something like
		// the page number, or the limit, and send a query cursor down the chain
		next.ServeHTTP(w, r)
	})
}
