FROM doraboateng/api-build:latest

# Configure apt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get --assume-yes --no-install-recommends install \
        apt-utils \
        git \
        lsb-release \
        procps

RUN go get -u -v \
    github.com/mdempsky/gocode \
    github.com/uudashr/gopkgs/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline \
    github.com/acroca/go-symbols \
    golang.org/x/tools/cmd/guru \
    golang.org/x/tools/cmd/gorename \
    github.com/rogpeppe/godef \
    github.com/zmb3/gogetdoc \
    github.com/sqs/goreturns \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/lint/golint \
    github.com/alecthomas/gometalinter \
    honnef.co/go/tools/... \
    github.com/golangci/golangci-lint/cmd/golangci-lint \
    github.com/mgechev/revive \
    github.com/derekparker/delve/cmd/dlv 2>&1

# gocode-gomod
RUN go get -x -d github.com/stamblerre/gocode 2>&1 && \
    go build -o gocode-gomod github.com/stamblerre/gocode && \
    mv gocode-gomod $GOPATH/bin/

# Copy default endpoint specific user settings overrides into container to specify Go path
COPY settings.vscode.json /root/.vscode-remote/data/Machine/settings.json

# Clean up
RUN apt-get autoremove --assume-yes && \
    apt-get clean --assume-yes && \
    rm --force --recursive /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog

# Set the default shell to bash rather than sh
ENV SHELL /bin/bash
