# Contributing

>TODO

```shell
# Build dev container
docker build --tag doraboateng/api:dev --target dev .

# Open IDE
code .
```

# Updating the schema

1. Update the schema file in question.
2. Run `go generate`:

```shell
./run shell
go generate ./src/...
```

# Resetting Dgraph

```shell
docker-compose down
rm -rf data/dgraph/*
docker-compose up --detach
```

# Tests

```shell
docker-compose run --no-deps --rm api go test -cover ./...
```
