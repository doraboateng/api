package models

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"strings"

	"github.com/dgraph-io/dgo/v200"
	"github.com/dgraph-io/dgo/v200/protos/api"
	"github.com/doraboateng/api/src/utils"
)

// Expression ...
type Expression struct {
	UUID                    string             `json:"uuid"`
	Type                    ExpressionType     `json:"type"`
	Titles                  []*Transliteration `json:"titles"`
	Languages               []*Language        `json:"languages"`
	PartOfSpeech            *PartOfSpeech      `json:"partOfSpeech"`
	NounType                *NounType          `json:"nounType"`
	Lexeme                  *Expression        `json:"lexeme"`
	LiteralTranslation      *string            `json:"literalTranslation"`
	PracticalTranslation    *string            `json:"practicalTranslation"`
	PracticalTranslationEng *string            `json:"practicalTranslation@eng:."`
	Meaning                 *string            `json:"meaning"`
	Tags                    []*Tag             `json:"tags"`
	RelatedExpressions      []*Expression      `json:"relatedExpressions"`
	References              []*Reference       `json:"references"`
}

func queryExpressions(
	ctx context.Context,
	client *dgo.Dgraph,
	query string,
	limit int,
) (*api.Response, error) {
	return nil, errors.New("not implemented")
}

func queryExpressionsInLanguage(
	ctx context.Context,
	client *dgo.Dgraph,
	langCode string,
	query string,
	limit int,
) (*api.Response, error) {
	limit = utils.QueryLimit(limit, 20)
	query = utils.Sanitize(query)

	if len(query) < 1 {
		return nil, errors.New("invalid search query for expressions")
	}

	if utils.ValidateLangCode(langCode) == false {
		return nil, errors.New("invalid language code")
	}

	txn := client.NewReadOnlyTxn()
	defer txn.Discard(ctx)

	return txn.QueryWithVars(
		ctx,
		strings.ReplaceAll(`query SearchExpressions($query: string) {
			result(func: type(Expression))
				@filter(
					anyoftext(<Expression.literalTranslation>@LANG_CODE, $query)
					OR anyoftext(<Expression.practicalTranslation>@LANG_CODE, $query)
					OR anyoftext(<Expression.meaning>@LANG_CODE, $query)
				)
			{
				<Expression.uuid>
				<Expression.type>
				<Expression.partOfSpeech>
				<Expression.literalTranslation>@LANG_CODE:.
				<Expression.practicalTranslation>@LANG_CODE:.
				<Expression.meaning@LANG_CODE:.>

				<Expression.titles> {
					<Transliteration.value>
				}

				<Expression.languages> {
					<Language.code>
					<Language.names> {
						<Transliteration.value>
					}
				}
			}
		}`, "LANG_CODE", langCode),
		map[string]string{"$query": query},
	)
}

// SearchExpressions ...
func SearchExpressions(
	ctx context.Context,
	client *dgo.Dgraph,
	langCode string,
	query string,
	limit int,
) ([]*Expression, error) {
	response, err := queryExpressionsInLanguage(ctx, client, langCode, query, limit)

	if err != nil {
		return nil, err
	}

	graphql := utils.ResponseToGraphQl(string(response.Json))

	type ResponseObj struct {
		Result []Expression `json:"result"`
	}

	var responseObj ResponseObj
	err = json.Unmarshal([]byte(graphql), &responseObj)

	if err != nil {
		return nil, err
	}

	var expressions []*Expression

	for i := 0; i < len(responseObj.Result); i++ {
		expressions = append(expressions, &responseObj.Result[i])
	}

	return expressions, nil
}

// GetExpressionSearchResults ...
func GetExpressionSearchResults(
	ctx context.Context,
	client *dgo.Dgraph,
	langCode string,
	query string,
) ([]*SearchResult, error) {
	expressions, err := SearchExpressions(ctx, client, langCode, query, 20)

	if err != nil {
		return nil, err
	}

	var results []*SearchResult

	for i := 0; i < len(expressions); i++ {
		if expressions[i].PracticalTranslationEng != nil {
			var practical string = *expressions[i].PracticalTranslationEng
			results = append(results, &SearchResult{
				Type: "expression",
				Title: fmt.Sprintf(
					"%s means \"%s\" in %s",
					expressions[i].Titles[0].Value,
					practical,
					expressions[i].Languages[0].Names[0].Value,
				),
				Description: "",
				// ResourceID: expressions[i].UUID,
				ResourceID: expressions[i].Titles[0].Value,
			})
		} else {
			log.Println("found expression without practical translation")
			log.Println(expressions[i])
		}
	}

	return results, nil
}
