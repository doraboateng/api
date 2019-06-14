FROM golang AS build-env
LABEL version="0.1.0"

# Set some environment variables.
ARG APP_ENV
ARG APP_VERSION
ARG GIT_HASH
ENV APP_ENV ${APP_ENV}
ENV APP_VERSION ${APP_VERSION}
ENV GIT_HASH ${GIT_HASH}

# Copy the source files into the container.
COPY ./src /go/src/github.com/doraboateng/api/src
WORKDIR /go/src/github.com/doraboateng/api/src

# Install project dependencies.
ADD ./dependencies.txt /go/src/github.com/doraboateng/api/
RUN go get -v < ../dependencies.txt
