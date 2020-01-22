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
func LanguagesHandler(r chi.Router) {
	r.Post("/", featureNotImplemented)
	r.Route("/{code}", func(r chi.Router) {
		r.Use(LanguageContext)
		r.Get("/", featureNotImplemented)
		r.Put("/", featureNotImplemented)
		r.Delete("/", featureNotImplemented)
	})
	
	r.With(tempPaginageLang).Get("/", featureNotImplemented)
	r.Get("/auto", featureNotImplemented)
	r.With(tempPaginageLang).Get("/search", featureNotImplemented)
	r.Get("/weekly", featureNotImplemented)
}

// ---
// ...
// ---

// LanguageContext middleware is used to load an Article object from
// the URL parameters passed through as the request. In case
// the Article could not be found, we stop here and return a 404.
func LanguageContext(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		render.Render(w, r, utils.NotFoundError(errors.New("language not found")))
	})
}

// paginate is a stub, but very possible to implement middleware logic
// to handle the request params for handling a paginated request.
func tempPaginageLang(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// just a stub.. some ideas are to look at URL query params for something like
		// the page number, or the limit, and send a query cursor down the chain
		next.ServeHTTP(w, r)
	})
}
