FROM golang AS build-env
LABEL version="0.1.0"

ARG APP_ENV
ENV APP_ENV ${APP_ENV}

ADD ./src /go/src/github.com/doraboateng/api/src
ADD ./migrations /go/src/github.com/doraboateng/api/migrations
WORKDIR /go/src/github.com/doraboateng/api/src

# Install project dependencies and migration tool.
ADD ./dependencies.txt /go/src/github.com/doraboateng/api/
RUN go get -v < ../dependencies.txt && \
    go get -u database/sql github.com/go-sql-driver/mysql && \
    go get -tags 'mysql' -u github.com/golang-migrate/migrate/cmd/migrate
