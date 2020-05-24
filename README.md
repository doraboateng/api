[![Build Status](https://travis-ci.com/kwcay/boateng-api.svg?branch=stable)](https://travis-ci.com/kwcay/boateng-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/eaf38d5d227bbeb85571/maintainability)](https://codeclimate.com/github/kwcay/boateng-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/eaf38d5d227bbeb85571/test_coverage)](https://codeclimate.com/github/kwcay/boateng-api/test_coverage)

<details>
    <summary>Table of Contents</summary>

- [Local Setup](#local-setup)
    - [Requirements](#requirements)
    - [Running the API locally](#running-the-api-locally)
    - [Published Ports](#published-ports)
    - [Viewing the log outputs from the services](#viewing-the-log-outputs-from-the-services)
    - [Creating an RDF backup](#creating-an-rdf-backup)
    - [Dgraph live loader](#dgraph-live-loader)
    - [Loading an RDF backup](#loading-an-rdf-backup)
- [Reporting Bugs](#reporting-bugs)
- [Reporting Security Issues](#reporting-security-issues)
- [Contributing](https://github.com/kwcay/boateng-graph-service/blob/stable/docs/contributing.md)
- [Deploying](https://github.com/kwcay/boateng-graph-service/blob/stable/docs/deploying.md)
- [License](#license)

</details>

# Local setup

## Requirements

- [Docker](https://www.docker.com) & [Docker Compose](https://docs.docker.com/compose/install)
- [Visual Studio Code](https://code.visualstudio.com)
- A POSIX-compliant terminal, such as:
    - [Visual Studio Code terminal](https://code.visualstudio.com/docs/editor/integrated-terminal)
    - [cmder](https://cmder.net)
    - [Cygwin](https://www.cygwin.com)
    - [Bash](https://www.gnu.org/software/bash)
    - [Zsh](https://www.zsh.org)

If you're on Linux or Mac, you already have a POSIX-compliant terminal.

**Optional, but recommended:**

- [BuildKit](https://docs.docker.com/develop/develop-images/build_enhancements)

## Running the API locally

```shell
docker-compose up --detach
```

When running for the first time, you might get this message:

```
ERROR: The image for the service you're trying to recreate has been removed. If you continue, volume data could be lost. Consider backing up your data before continuing.

Continue with the new image? [yN]
```

In which case you can go ahead and type `y` and continue.

To stop the API:

```shell
docker-compose stop
```

## Published ports

Port numbers published to your host machine.

| Port | Service |
| --- | --- |
| 8800 | API |
| 8810 | [GraphiQL (todo)](https://github.com/graphql/graphiql) |
| 8811 | Dgraph Ratel |
| 8817 | [Dgraph Alpha](https://dgraph.io/docs/deploy/#more-about-dgraph-alpha) (HTTP) |
| 8818 | [Dgraph Alpha](https://dgraph.io/docs/deploy/#more-about-dgraph-alpha) (gRPC) |
| 8819 | [Dgraph Zero](https://dgraph.io/docs/deploy/#more-about-dgraph-zero) |

## Viewing the log outputs from the services

```shell
# Displaying all logs.
docker-compose logs

# Displaying logs for the API service.
docker-compose logs api

# Displaying logs for several services, e.g. API and Dgraph Alpha
docker-compose logs api alpha

# Tailing the last 5 lines of the logs from the API service.
docker-compose logs --tail 5 api

# Following the logs for the API service as they come in (CMD/CTRL+C to exit).
docker-compose logs --follow api

# Following the logs for several services as they come in, e.g. Dgraph Alpha and Dgraph Zero.
docker-compose logs --follow api alpha zero
```

For more details, see the [docs](https://docs.docker.com/compose/reference/logs) or run the command `docker-compose logs --help`

## Creating an RDF backup

```shell
./run shell alpha

# Create RDF backup.
curl --url http://localhost:8080/admin \
    --header 'content-type: application/json' \
    --data '{"query":"mutation {export(input: {format: \"rdf\"}) {response {message code}}}"}'
tar --create --file temp.rdf.tar.gz --gzip $(ls --directory -t export/* | head -1)
mv temp.rdf.tar.gz doraboateng.$(date +"%Y-%m-%d").$(sha1sum temp.rdf.tar.gz | cut -c 1-6).rdf.tar.gz

# Note the name of the backup file, then exit the container.
ls doraboateng.*.rdf.tar.gz
exit

# Copy RDF backup.
docker cp boateng-api_alpha_1:/dgraph/doraboateng.2020-05-21.b406df.rdf.tar.gz tmp/
```

## Loading an RDF backup

```shell
# Copy backup file into Dgraph Alpha container.
docker cp /path/to/rdf boateng-api_alpha_1:/tmp/rdf.tar.gz

# Extract backup file.
./run shell alpha
mkdir -p /tmp/restore/$(date +'%Y-%m-%d') \
    && mv /tmp/rdf.tar.gz /tmp/restore/$(date +'%Y-%m-%d')/ \
    && cd /tmp/restore/$(date +'%Y-%m-%d') \
    && tar --extract --gzip --file rdf.tar.gz \
    && cp export/**/* .

# Load backup file.
dgraph live \
    --alpha 127.0.0.1:9080 \
    --files g01.rdf.gz \
    --schema g01.schema.gz \
    --use_compression \
    --zero zero:5080
```

# Reporting Bugs

>TODO

# Reporting Security Issues

>TODO

# License

[GNU General Public License v3](https://github.com/kwcay/boateng-api/blob/stable/LICENSE)

Copyright © Kwahu & Cayes
