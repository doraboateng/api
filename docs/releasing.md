# Releasing

1. Create a release on [Github](https://github.com/kwcay/boateng-api/releases/new).
    - Use [semantic versioning](https://semver.org).
    - Tip: check out [previous releases](https://github.com/kwcay/boateng-api/releases) for inspiration.
    - Tip: you can see the code changes since the last release by browsing to `https://github.com/kwcay/boateng-api/compare/VERSION...stable` where VERSION is tag of the last release (e.g. https://github.com/kwcay/boateng-api/compare/0.7.0...stable).

2. Make sure you've pulled the latest tags:

```shell
git fetch --tags
```

3. Create and publish the API to Docker Hub:

```shell
./run build-docker
```
