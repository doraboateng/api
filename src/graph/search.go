package graph

import (
	"context"
	"log"

	"github.com/doraboateng/api/src/graph/models"
)

func mergeResults(
	results []*models.SearchResult,
	extraResults []*models.SearchResult,
	err error,
) []*models.SearchResult {
	if err != nil {
		log.Println(err)

		return results
	}

	return append(results, extraResults...)
}

// Search ...
func Search(ctx context.Context, query string) []*models.SearchResult {
	client, close := GetClient()
	defer close()

	var results []*models.SearchResult

	languages, err := models.GetLanguageSearchResults(ctx, client, query)
	results = mergeResults(results, languages, err)

	expressions, err := models.GetExpressionSearchResults(ctx, client, "eng", query)
	results = mergeResults(results, expressions, err)

	return results
}
