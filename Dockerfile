FROM golang AS build-env
LABEL version="0.1.0"

ARG APP_ENV
ENV APP_ENV ${APP_ENV}

COPY ./src /go/src/github.com/doraboateng/api/src
WORKDIR /go/src/github.com/doraboateng/api/src

# Install project dependencies.
ADD ./dependencies.txt /go/src/github.com/doraboateng/api/
RUN go get -v < ../dependencies.txt
