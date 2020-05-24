package models

import (
	"context"

	"github.com/dgraph-io/dgo/v200"
	"github.com/dgraph-io/dgo/v200/protos/api"
	"github.com/kwcay/boateng-api/src/utils"
)

// SearchLanguages ...
func SearchLanguages(
	ctx context.Context,
	txn *dgo.Txn,
	query string,
	limit int,
) (*api.Response, error) {
	limit = utils.QueryLimit(limit, 5)
	query = utils.Sanitize(query)

	if len(query) < 1 {
		return txn.Query(ctx, `{
			result(func: type(Language)) {
				<Language.code>
				<Language.names> {
					<Transliteration.value>
				}
			}
		}`)
	}

	return txn.QueryWithVars(
		ctx,
		`query SearchLanguages($query: string) {
			result(func: type(Language)) @cascade {
			    <Language.code>
			    <Language.names> @filter(alloftext(Transliteration.value, $query)) {
				    <Transliteration.value>
			    }
			}
		}`,
		map[string]string{"$query": query},
	)
}
