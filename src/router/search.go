package router

import (
	"context"
	"fmt"
	"net/http"

	"github.com/doraboateng/api/src/graph"
	"github.com/doraboateng/api/src/graph/models"
	"github.com/doraboateng/api/src/utils"
	"github.com/go-chi/render"
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

func getResourceURL(resource models.SearchResult) string {
	switch resource.Type {
	case "expression":
		return "https://doraboateng.com"

	case "language":
		return fmt.Sprintf("https://doraboateng.com/%s", resource.ResourceID)

	default:
		// TODO: log warning
		return "https://doraboateng.com"
	}
}

// SearchHandler handles general search queries.
func SearchHandler(writer http.ResponseWriter, request *http.Request) {
	ctx := context.Background()
	query := utils.Sanitize(request.URL.Query().Get("q"))
	response := SearchResults{
		Query:   query,
		Results: []SearchResult{},
	}

	results := graph.Search(ctx, query)

	for i := 0; i < len(results); i++ {
		response.Results = append(response.Results, SearchResult{
			Title:       results[i].Title,
			Link:        getResourceURL(*results[i]),
			Description: "",
		})
	}

	if err := render.Render(writer, request, &response); err != nil {
		render.Render(writer, request, utils.RenderingError(err))
		return
	}
}

// Render ...
func (res *SearchResults) Render(w http.ResponseWriter, r *http.Request) error {
	// Pre-processing before a response is marshalled and sent across the wire

	return nil
}
