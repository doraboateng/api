package resolvers

import (
	"context"
	"log"

	"github.com/kwcay/boateng-api/src/graph/models"
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

func (r *queryResolver) Search(
	ctx context.Context,
	query string,
) ([]*models.SearchResult, error) {
	var results []*models.SearchResult

	languages, err := models.GetLanguageSearchResults(ctx, r.Dgraph, query)
	results = mergeResults(results, languages, err)

	return results, nil
}
