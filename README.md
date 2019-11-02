[![Build Status](https://travis-ci.com/doraboateng/api.svg?branch=stable)](https://travis-ci.com/doraboateng/api)
[![Maintainability](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/maintainability)](https://codeclimate.com/github/doraboateng/api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/test_coverage)](https://codeclimate.com/github/doraboateng/api/test_coverage)

<details>
  <summary>Quickstart</summary>

```shell
# Clone the repository.
git clone git@github.com:doraboateng/api.git
cd api

# Run the database migrations. This will launch the API locally, build
# the base image and run the migration files.
./run migrate

# Launch your IDE.
code .
```

</details>

<details>
  <summary>Table of contents</summary>

- [Local development](#local-development)
  - [Required software](#required-software)
  - [Recommended software](#recommended-software)
- [Tests](#tests)
- [Travis](#travis)
  - [Adding and updating encrypted values](#adding-and-updating-encrypted-values)

</details>

# Local development

## Required software

- [Docker](https://docs.docker.com) & [Docker Compose](https://docs.docker.com/compose)

## Recommended software

- [Visual Studio Code](https://code.visualstudio.com) with the [Remote Development extensions](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
- [DBeaver](https://dbeaver.io) (or [alternative](https://alternativeto.net/software/dbeaver)) for inspecting databases.

# Tests

```shell
./run test
```

# Travis

## Adding and updating encrypted values

Using the [Travis CLI](https://github.com/travis-ci/travis.rb), it's possible to [encrypt sensitive information](https://docs.travis-ci.com/user/encryption-keys) in the Travis file:

```shell
# Encrypt an environment variable using the travis CLI:
travis encrypt --com SOMEVAR="secretvalue"
```
