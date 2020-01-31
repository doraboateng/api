package handlers

import (
	"errors"
	"net/http"

	"github.com/go-chi/chi"
	"github.com/go-chi/render"
	"github.com/kwcay/boateng-api/src/utils"
)

// --
// Structures
// --

// ---
// Router handlers
// ---

// DefinitionsHandler - handles all definition routes.
func DefinitionsHandler(r chi.Router) {
	r.Post("/", featureNotImplemented)
	r.Route("/{id}", func(r chi.Router) {
		r.Use(DefinitionContext)
		r.Get("/", featureNotImplemented)
		r.Put("/", featureNotImplemented)
		r.Delete("/", featureNotImplemented)
	})

	r.With(tempPaginateDef).Get("/", featureNotImplemented)
	r.Get("/daily/{type:[a-z-]+}", featureNotImplemented)
	r.Get("/random/{lang:[a-z-]+}", featureNotImplemented)
	r.With(tempPaginateDef).Get("/search", featureNotImplemented)
	r.With(DefinitionContext).Get("/title/{slug:[a-z-]+}", featureNotImplemented)
}

func featureNotImplemented(w http.ResponseWriter, r *http.Request) {
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
func tempPaginateDef(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// just a stub.. some ideas are to look at URL query params for something like
		// the page number, or the limit, and send a query cursor down the chain
		next.ServeHTTP(w, r)
	})
}
