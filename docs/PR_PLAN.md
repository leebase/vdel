# VDEL PR Roadmap

## Overview
- VDEL will ship as a Docker-first analytics engineering desktop with opinionated tooling.
- This roadmap sequences foundational infrastructure, data tooling, and release automation.

## Branching & Release
- `main` remains deployable; feature work happens in short-lived `feat/*` and `docs/*` branches.
- Tags `vX.Y.Z` publish images to `ghcr.io/<owner>/vdel:latest` and `ghcr.io/<owner>/vdel:vX.Y.Z`.

## Environments, Ports & Volumes
| Environment | Ports | Volumes |
|-------------|-------|---------|
| Dev (Docker Compose) | 8080 (XFCE/noVNC), 8443 (code-server), 8501 (Streamlit) | `vdel_home` → `/home/developer/workspace`, `vdel_codeserver` → code-server data |

## PR Sequence

### 01. Repo scaffold — Status: DONE ✅
**Title**: Scaffold VDEL repo

**Goal**: Establish base repository structure, licensing, and collaboration hygiene.

**Changes**:
- `README.md`
- `.gitignore`
- `LICENSE`
- `docs/`
- `.github/pull_request_template.md`

**Acceptance Criteria**:
- [x] Repo has MIT license and contributor docs skeleton.
- [x] PR template guides roadmap-driven contributions.
- [x] README introduces VDEL vision and dev setup assumptions.
- [x] Docs folder includes placeholders aligned to roadmap.

**Verify**:
```sh
ls -R | head
```

### 02. Hello container + docker-compose + Makefile + CI build to GHCR — Status: DONE ✅
**Title**: Bootstrap container build & publish

**Goal**: Deliver minimal runnable container, compose stack, and automated GHCR publishing on `main`.

**Changes**:
- `Dockerfile`
- `docker-compose.yml`
- `Makefile`
- `.github/workflows/build.yml`
- `docs/build.md`

**Acceptance Criteria**:
- [x] `docker compose up` boots a placeholder service.
- [x] `make build` and `make push` support GHCR tagging to `ghcr.io/<owner>/vdel:latest`.
- [x] CI workflow builds and pushes image with cache reuse on `main`.
- [x] Build docs capture registry auth and variables.

**Verify**:
```sh
make build
make push
```

### 03. XFCE + VNC + noVNC + code-server; non-root user; expose :8080/:8443 — Status: DONE ✅
**Title**: Add desktop + IDE services

**Goal**: Integrate XFCE desktop, noVNC, and code-server running as `developer` user with secure defaults.

**Changes**:
- `Dockerfile`
- `docker-compose.yml`
- `config/supervisor/`
- `entrypoint.sh`
- `docs/desktop.md`

**Acceptance Criteria**:
- [x] Container boots XFCE accessible via noVNC on :8080.
- [x] code-server listens on :8443 with password `vibe`.
- [x] Non-root `developer` owns workspace directory.
- [x] Supervisor manages desktop and IDE processes (temporary multi-service until convergence).

**Verify**:
```sh
docker compose up --build
```

### 04. Data toolbelt install — Status: DONE ✅
**Title**: Provision data engineering toolbelt

**Goal**: Install core CLI/SDK tooling (Snowflake, dbt, SQL, notebooks) within the container.

**Changes**:
- `Dockerfile`
- `requirements.txt`
- `Makefile`
- `scripts/install_data_tools.sh`
- `docs/tooling.md`

**Acceptance Criteria**:
- [x] Snowflake CLI (`sf`) and connector import succeed.
- [x] dbt-snowflake, sqlfluff (snowflake), DuckDB (via python), sqlite3, psql, mysql-client available.
- [x] JupyterLab launches via make target and is reachable on :8888.
- [x] Make targets lint and update toolbelt dependencies.

**Verify**:
```sh
docker compose run --rm vdel sf --help
```

### 05. DBeaver CE install & desktop shortcuts; workspace volume wired
**Title**: Ship DBeaver desktop integration

**Goal**: Bundle DBeaver CE with launchers and ensure `vdel_home` volume mounts under `/home/developer/workspace`.

**Changes**:
- `Dockerfile`
- `config/desktop/`
- `docker-compose.yml`
- `docs/desktop.md`
- `scripts/setup_shortcuts.sh`

**Acceptance Criteria**:
- [ ] DBeaver CE launches via desktop shortcut.
- [ ] Workspace volume persists across container restarts.
- [ ] Shortcuts stored in `/usr/share/applications/` and desktop.
- [ ] Shortcut script idempotently rebuilds entries.

**Verify**:
```sh
docker compose run --rm vdel ls /home/developer/workspace
```

### 06. Examples & docs
**Title**: Author reference examples

**Goal**: Provide Snowflake quickstart, demo notebook, and minimal dbt project documentation.

**Changes**:
- `docs/snowflake_quickstart.md`
- `examples/notebooks/demo.ipynb`
- `examples/dbt/`
- `README.md`
- `docs/examples.md`

**Acceptance Criteria**:
- [ ] Quickstart covers Snowflake auth and sample queries.
- [ ] Demo notebook runs with DuckDB and Snowflake connector.
- [ ] dbt scaffold includes sample model and README.
- [ ] Docs cross-link launcher and toolbelt usage.

**Verify**:
```sh
dbt debug --profiles-dir examples/dbt
```

### 07. Streamlit “Launcher” app; expose :8501; desktop shortcut
**Title**: Add Streamlit launcher

**Goal**: Deliver Streamlit-based launcher UI with desktop entry and compose port mapping 8501.

**Changes**:
- `app/launcher/streamlit_app.py`
- `requirements.txt`
- `docker-compose.yml`
- `config/desktop/launcher.desktop`
- `docs/launcher.md`

**Acceptance Criteria**:
- [ ] Streamlit app lists core tooling launch actions.
- [ ] Port :8501 exposed via compose and documented.
- [ ] Desktop shortcut launches Streamlit via browser.
- [ ] Launcher reads defaults `VNC_PASSWORD` and `CODE_SERVER_PASSWORD`.

**Verify**:
```sh
docker compose up launcher
```

### 08. Release workflow: tag `v*.*.*` → multi-tag push to GHCR
**Title**: Automate versioned releases

**Goal**: Implement GitHub Actions workflow that builds and pushes `latest` and semver tags on release.

**Changes**:
- `.github/workflows/release.yml`
- `docs/release.md`
- `Makefile`
- `CHANGELOG.md`
- `.github/ISSUE_TEMPLATE/release.md`

**Acceptance Criteria**:
- [ ] Tagging `vX.Y.Z` triggers workflow pushing both tags to GHCR.
- [ ] Release notes template references changelog entries.
- [ ] Make targets support semver tagging.
- [ ] Changelog updated automatically during release.

**Verify**:
```sh
gh workflow run release.yml --ref v0.1.0
```

### 09. Flavors (lite/standard/full) with compose profiles and CI matrix
**Title**: Introduce image flavors

**Goal**: Define compose profiles and CI matrix builds for lite/standard/full variants with targeted tooling.

**Changes**:
- `docker-compose.yml`
- `.github/workflows/build.yml`
- `docs/flavors.md`
- `Dockerfile`
- `Makefile`

**Acceptance Criteria**:
- [ ] Compose profiles select services and tooling per flavor.
- [ ] CI builds all flavors in matrix and pushes tags.
- [ ] Docs clarify flavor differences and usage.
- [ ] Makefile exposes flavor-aware targets.

**Verify**:
```sh
make build FLAVOR=lite
make build FLAVOR=standard
make build FLAVOR=full
```

### 10. Smoke tests + healthchecks + size trim pass
**Title**: Harden image and trim size

**Goal**: Add automated smoke tests, container healthchecks, and prune unused packages to reduce image size.

**Changes**:
- `tests/smoke/`
- `.github/workflows/test.yml`
- `Dockerfile`
- `docs/operations.md`
- `scripts/measure_image_size.sh`

**Acceptance Criteria**:
- [ ] Smoke tests cover desktop, code-server, Streamlit, and key CLIs.
- [ ] Healthchecks defined in Dockerfile/compose.
- [ ] Image size reduced versus baseline measurement.
- [ ] Size measurement script outputs comparison table.

**Verify**:
```sh
pytest tests/smoke
```
