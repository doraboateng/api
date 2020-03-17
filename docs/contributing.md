<details>
  <summary>Table of contents</summary>

- [Setup](#setup)
  - [Required software](#required-software)
  - [Recommended software](#recommended-software)
  - [Database](#database)
- [Debugging](#debugging)
- [Tests](#tests)

</details>

# Setup

## Required software

- [Docker](https://docs.docker.com) & [Docker Compose](https://docs.docker.com/compose)

## Recommended software

- [Visual Studio Code](https://code.visualstudio.com) with the [Remote Development extensions](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
- [DBeaver](https://dbeaver.io) (or [alternative](https://alternativeto.net/software/dbeaver)) for inspecting databases.
- [yEd Graph Editor](https://www.yworks.com/products/yed)

## Database

>TODO: migrate

```shell
./run migrate

# Manually.
./run shell api
migrate -database "mysql://boateng_dev:boateng_dev@tcp(db:3306)/boateng_dev" \
  -path ../migrations -verbose up
```

>TODO: setup DB client

| Parameter | Value |
| --- | --- |
| Database type | MariaDB (compatible with MySQL) |
| Host | localhost |
| Port | 13306 |
| Database name | boateng_dev |
| Database username | boateng_dev |
| Database password | boateng_dev |
| Server timezone | UTC |

# Debugging

>TODO

```shell
./run logs
./run shell
```

## Database

>TODO

```shell
./run shell db
```

# Tests

>TODO

```shell
./run shell
go test -cover ./...
```
