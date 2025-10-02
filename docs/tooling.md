# Data Toolbelt

PR 04 adds core CLI/SDK tools for analytics engineering inside the `vdel` service.

## What’s Included
- Snowflake CLI (`sf` alias to `snow`), Snowflake Python connector
- dbt-snowflake, sqlfluff (+ dbt templater), DuckDB CLI
- SQLite (`sqlite3`), PostgreSQL (`psql`), MySQL client (`mysql`/`mariadb`)
- JupyterLab

## Quick Checks
```sh
# Snowflake CLI
docker compose run --rm vdel sf --help

# dbt
docker compose run --rm vdel dbt --version

# SQLFluff
make lint

# DB CLIs
docker compose run --rm vdel duckdb --version
docker compose run --rm vdel sqlite3 --version
docker compose run --rm vdel psql --version
docker compose run --rm vdel mysql --version || docker compose run --rm vdel mariadb --version

# JupyterLab
make jupyter
curl -fsS http://localhost:8888 >/dev/null && echo "Jupyter OK"
```

## Updating Tools
```sh
make update-toolbelt
```

Tools are installed for the non-root `developer` user; CLI shims live in `~/.local/bin` (on PATH by default).
