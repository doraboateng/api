package resolvers

import (
	"context"

	"github.com/doraboateng/api/src/graph/models"
)

type expressionResolver struct{ *Resolver }

func (r *queryResolver) Expression(ctx context.Context, code string) (*models.Expression, error) {
	panic("not implemented")
}

func (r *queryResolver) Expressions(ctx context.Context) ([]*models.Expression, error) {
	panic("not implemented")
}
