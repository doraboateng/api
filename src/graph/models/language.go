package models

import (
	"context"
	"encoding/json"

	"github.com/dgraph-io/dgo/v200"
	"github.com/dgraph-io/dgo/v200/protos/api"
	"github.com/doraboateng/api/src/utils"
)

func queryLanguages(
	ctx context.Context,
	client *dgo.Dgraph,
	query string,
	limit int,
) (*api.Response, error) {
	limit = utils.QueryLimit(limit, 5)
	query = utils.Sanitize(query)

	transaction := client.NewReadOnlyTxn()
	defer transaction.Discard(ctx)

	if len(query) < 1 {
		return transaction.Query(ctx, `{
			result(func: type(Language)) {
				<Language.code>
				<Language.names> {
					<Transliteration.value>
				}
			}
		}`)
	}

	return transaction.QueryWithVars(
		ctx,
		`query SearchLanguages($query: string) {
			result(func: type(Language)) @cascade {
			    <Language.code>
			    <Language.names> @filter(anyoftext(Transliteration.value, $query)) {
				    <Transliteration.value>
			    }
			}
		}`,
		map[string]string{"$query": query},
	)
}

// SearchLanguages finds language records matching the search query.
func SearchLanguages(
	ctx context.Context,
	client *dgo.Dgraph,
	query string,
	limit int,
) ([]*Language, error) {
	response, err := queryLanguages(ctx, client, query, limit)

	if err != nil {
		return nil, err
	}

	graphql := utils.ResponseToGraphQl(string(response.Json))

	type ResponseObj struct {
		Result []Language `json:"result"`
	}

	var responseObj ResponseObj
	err = json.Unmarshal([]byte(graphql), &responseObj)

	if err != nil {
		return nil, err
	}

	var languages []*Language

	for i := 0; i < len(responseObj.Result); i++ {
		languages = append(languages, &responseObj.Result[i])
	}

	return languages, nil
}

// GetLanguageSearchResults creates SearchResults for languages matching the
// search query.
func GetLanguageSearchResults(
	ctx context.Context,
	client *dgo.Dgraph,
	query string,
) ([]*SearchResult, error) {
	languages, err := SearchLanguages(ctx, client, query, 10)

	if err != nil {
		return nil, err
	}

	var results []*SearchResult

	for i := 0; i < len(languages); i++ {
		results = append(results, &SearchResult{
			Type:        "language",
			Title:       languages[i].Names[0].Value,
			Description: "",
			ResourceID:  languages[i].Code,
		})
	}

	return results, nil
}
