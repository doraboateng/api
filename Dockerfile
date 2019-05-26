FROM golang

ARG APP_ENV
ENV APP_ENV $APP_ENV

COPY ./src /go/src/github.com/doraboateng/api/src
WORKDIR /go/src/github.com/doraboateng/api/src

RUN go get -v && go build

EXPOSE 8008
