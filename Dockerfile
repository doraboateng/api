ARG GO_VERSION=1.13.7

# Dev stage.
FROM golang:${GO_VERSION}-alpine AS dev
LABEL version="0.2.0"

RUN apk add curl git htop vim

RUN cd /tmp && \
    curl --location \
        https://github.com/golang-migrate/migrate/releases/download/v4.8.0/migrate.linux-amd64.tar.gz \
        | tar xvz && \
    mv ./migrate.linux-amd64 /usr/bin/migrate

ADD . /root/boateng-api
WORKDIR /root/boateng-api/src

RUN go get -u -v \
        database/sql github.com/go-sql-driver/mysql \
        github.com/cosmtrek/air

# Build stage.
FROM dev as build

ARG BUILD_VERSION
ARG GIT_HASH
ARG BUILD_NAME
RUN go build \
        -ldflags "-X main.version=${BUILD_VERSION} -X main.gitHash=${GIT_HASH}" \
        -o ${BUILD_NAME}

# Production stage.
FROM scratch AS prod

ENV APP_BUILD_PATH="/var/app" \
    APP_BUILD_NAME="main"
WORKDIR ${APP_BUILD_PATH}
COPY --from=build ${APP_BUILD_PATH}/${APP_BUILD_NAME} ${APP_BUILD_PATH}/

EXPOSE ${APP_PORT}
ENTRYPOINT ["/var/app/main"]
CMD ""
