package router

import (
	"net/http"

	"github.com/go-chi/render"
	"github.com/kwcay/boateng-api/src/utils"
)

// SearchResult describes the JSON shape of a search result.
type SearchResult struct {
	Title       string `json:"title"`
	Link        string `json:"link"`
	Description string `json:"description"`
}

// SearchResults describes the JSON shape of result set.
type SearchResults struct {
	Query   string         `json:"query"`
	Results []SearchResult `json:"results"`
}

// SearchHandler handles general search queries.
func SearchHandler(writer http.ResponseWriter, request *http.Request) {
	results := SearchResults{
		Query:   "...",
		Results: []SearchResult{},
	}

	if err := render.Render(writer, request, &results); err != nil {
		render.Render(writer, request, utils.RenderingError(err))
		return
	}
}

// Render ...
func (res *SearchResults) Render(w http.ResponseWriter, r *http.Request) error {
	// Pre-processing before a response is marshalled and sent across the wire

	return nil
}
