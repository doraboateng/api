ARG GO_VERSION=1.13.7

# Dev stage.
FROM golang:${GO_VERSION}-alpine AS dev
LABEL version="0.7.0"

RUN apk add curl git htop vim && \
    cd /tmp && \
    curl --location \
        https://github.com/golang-migrate/migrate/releases/download/v4.8.0/migrate.linux-amd64.tar.gz \
        | tar xvz && \
    mv ./migrate.linux-amd64 /usr/bin/migrate

ARG PROJECT_ROOT=/root/boateng-api
ADD . ${PROJECT_ROOT}
WORKDIR ${PROJECT_ROOT}/src

RUN go get -u -v \
        database/sql github.com/go-sql-driver/mysql \
        github.com/cosmtrek/air

# Build stage.
FROM dev as build

ARG BUILD_VERSION
ARG GIT_HASH
ARG BUILD_NAME
RUN CGO_ENABLED=0 GOOS=linux go build \
        -ldflags "-X main.version=${BUILD_VERSION} -X main.gitHash=${GIT_HASH}" \
        -o /tmp/${BUILD_NAME}
RUN chmod +x /tmp/${BUILD_NAME}

# Production stage.
FROM scratch AS prod

ARG BUILD_NAME
WORKDIR /var/app
COPY --from=build /tmp/${BUILD_NAME} /var/app/boateng-api

EXPOSE ${APP_PORT}
ENTRYPOINT ["/var/app/boateng-api"]
