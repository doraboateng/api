>TODO

- [Running  tests](#running-tests)
- [Travis](#travis)
  - [Adding and updating encrypted values](#adding-and-updating-encrypted-values)

# Running tests

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
