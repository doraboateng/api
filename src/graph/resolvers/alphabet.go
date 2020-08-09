package resolvers

import (
	"context"

	"github.com/doraboateng/api/src/graph/models"
)

type alphabetResolver struct{ *Resolver }

func (r *queryResolver) Alphabet(ctx context.Context, code string) (*models.Alphabet, error) {
	panic("not implemented")
}

func (r *queryResolver) Alphabets(ctx context.Context) ([]*models.Alphabet, error) {
	panic("not implemented")
}
