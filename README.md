# Dora Boateng API

[![Build Status](https://travis-ci.com/doraboateng/api.svg?branch=stable)](https://travis-ci.com/doraboateng/api)
[![Maintainability](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/maintainability)](https://codeclimate.com/github/doraboateng/api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/test_coverage)](https://codeclimate.com/github/doraboateng/api/test_coverage)

<details>
  <summary>Quickstart</summary>

```shell
# Clone the repository.
git clone git@github.com:doraboateng/api.git
cd api

# Launch Visual Code Insiders
# https://code.visualstudio.com/docs/remote/containers
code-insiders .

# Run the API locally.
./run
```
</details>

<details>
  <summary>Table of contents</summary>

- [Local development](#local-development)
- [Tests](#tests)
- [Travis](#travis)
  - [Adding and updating encrypted values](#adding-and-updating-encrypted-values)
</details>

# Local development

Follow the [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers) to install [Visual Studio Code Insiders](https://code.visualstudio.com/insiders) along with the [Remote Development extensions](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack). Once that's ready, you can launch Visual Studio Code Insiders using the `code-insiders` command:

```shell
code-insiders .
```

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
