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

# Run the API locally.
./run
```
</details>

<details>
  <summary>Table of contents</summary>

- [Tests](#tests)
- [Travis](#travis)
  - [Adding and updating encrypted values](#adding-and-updating-encrypted-values)
</details>

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