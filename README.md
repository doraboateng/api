[![Build Status](https://travis-ci.com/doraboateng/api.svg?branch=stable)](https://travis-ci.com/doraboateng/api)
[![Maintainability](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/maintainability)](https://codeclimate.com/github/doraboateng/api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/af6ea36778ba43f5fc1d/test_coverage)](https://codeclimate.com/github/doraboateng/api/test_coverage)

<details>
  <summary>Quickstart</summary>

```shell
# Clone the repository.
git clone git@github.com:doraboateng/api.git
cd api

# Run the API locally.
./run

# Launch your IDE.
code .
```

</details>

<details>
  <summary>Table of contents</summary>

- [Local development](#local-development)
  - [Shellcheck](#shellcheck)
- [Tests](#tests)
- [Travis](#travis)
  - [Adding and updating encrypted values](#adding-and-updating-encrypted-values)

</details>

# Local development

We use [Visual Studio Code](https://code.visualstudio.com) with the [Remote Development extensions](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).

## Shellcheck

You can disable some [Shellcheck](https://github.com/koalaman/shellcheck) rules in Visual Studio Code from the user or workspace settings. For example, to ignore rule [SC1091](https://github.com/koalaman/shellcheck/wiki/SC1091):

```json
{
  "shellcheck.exclude": ["SC1091"]
}
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
