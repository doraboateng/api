package resolvers

import (
	"context"
	"encoding/json"
	"log"
	"strings"

	"github.com/kwcay/boateng-api/src/graph/models"
)

type languageResolver struct{ *Resolver }

func (r *queryResolver) Language(ctx context.Context, code string) (*models.Language, error) {
	transaction := r.Dgraph.NewReadOnlyTxn()
	defer transaction.Discard(ctx)

	variables := make(map[string]string)
	variables["$code"] = code
	log.Printf("Querying Language with %v\n", variables)

	query := `
		query GetLanguage($code: string) {
			result(func: eq(<Language.code>, $code)) {
				<Language.code>
				<Language.names> {
					<Transliteration.value>
				}
			}
		}
	`

	response, err := transaction.QueryWithVars(ctx, query, variables)

	if err != nil {
		return nil, err
	}

	// Convert Dgraph's JSON shape into the intended JSON shape so
	// we can unmarshal it properly.
	responseJSON := strings.ReplaceAll(string(response.Json), "Language.", "")
	responseJSON = strings.ReplaceAll(responseJSON, "Transliteration.", "")

	type ResponseObj struct {
		Result []models.Language `json:"result"`
	}

	var responseObj ResponseObj
	err = json.Unmarshal([]byte(responseJSON), &responseObj)

	if err != nil {
		return nil, err
	}

	var language *models.Language

	if len(responseObj.Result) == 1 {
		language = &responseObj.Result[0]
	}

	return language, nil
}

// Languages ...
func (r *queryResolver) Languages(
	ctx context.Context,
	searchQuery *string,
) ([]*models.Language, error) {
	strQuery := ""

	if searchQuery != nil {
		strQuery = *searchQuery
	}

	return models.SearchLanguages(ctx, r.Dgraph, strQuery, 5)
}
