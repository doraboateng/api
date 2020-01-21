package handlers

import (
	"net/http"

	"github.com/doraboateng/api/src/utils"
	"github.com/go-chi/render"
)

// --
// Structures
// --

// Locale represents a region/language pair.
type Locale struct {
	Code string `json:"code"`
	Name string `json:"name"`
}

// LocalesResponse is the response payload for the Status data model.
type LocalesResponse struct {
	Locales *[]Locale
}

// ---
// Router methods
// ---

// LocalesHandler - returns supported locales.
func LocalesHandler(w http.ResponseWriter, r *http.Request) {
	en := Locale{
		Code: "en",
		Name: "English",
	}

	fr := Locale{
		Code: "fr",
		Name: "Français",
	}

	locales := []Locale{en, fr}

	if err := render.Render(w, r, localesResponse(&locales)); err != nil {
		render.Render(w, r, utils.RenderingError(err))
		return
	}
}

// ---
// Response handlers
// ---

// Render - renders a LocalesResponse
func (locales *LocalesResponse) Render(w http.ResponseWriter, r *http.Request) error {
	// Pre-processing before a response is marshalled and sent across the wire

	return nil
}

func localesResponse(locales *[]Locale) render.Renderer {
	return &LocalesResponse{Locales: locales}
}
