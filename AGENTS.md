# Repository Guidelines

>This guide is for contributors and tooling agents working in the VDEL (Vibe Data Engineer Linux) repo.

## Project Structure & Module Organization
- Current folders: `README.md`, `LICENSE`, `docs/PR_PLAN.md`.
- Planned (see `docs/PR_PLAN.md`): `Dockerfile`, `docker-compose.yml`, `Makefile`, `config/`, `scripts/`, `examples/`, `app/launcher/`, `.github/`.
- Place container/runtime config in `config/`; helper scripts in `scripts/`; examples and docs under `examples/` and `docs/`.

## Build, Run, and Dev Commands
- Compose (when present):
  - `docker compose up -d` — build and start desktop + IDE.
  - `docker compose logs -f vdel` — tail main service logs.
  - `docker compose down` (or `-v` to clear volumes; destructive).
- Make (when present):
  - `make build` — build image(s).
  - `make push` — push to GHCR.
  - `make clean` — remove local artifacts.

## Coding Style & Naming Conventions
- Dockerfile: prefer pinned versions, logical layers, `RUN set -eux; ...` with `\` line wraps.
- YAML (compose): 2-space indent; service name `vdel`; lowercase keys.
- Shell scripts: `bash`, `set -euo pipefail`; functions `lower_snake_case`; files `kebab-case.sh`.
- Python (launcher/tests later): Black defaults (88), isort; modules `snake_case.py`.
- Recommended linters (not enforced yet): `shellcheck`, `shfmt`, `hadolint`, `yamllint`, `black`.

## Testing Guidelines
- Treat acceptance criteria in `docs/PR_PLAN.md` as tests for each PR.
- Smoke checks (once stack exists):
  - Open `http://localhost:8080` (XFCE/noVNC) and `http://localhost:8443` (code-server).
  - `docker compose run --rm vdel sf --help` (after Snowflake tools PR).
- Name example notebooks and dbt models clearly (e.g., `examples/notebooks/demo.ipynb`).

## Commit & Pull Request Guidelines
- Branches: `feat/*`, `fix/*`, `docs/*` (short-lived, rebased).
- Commits: Conventional style (e.g., `feat(desktop): add noVNC service`), ≤72-char subject.
- PRs: link roadmap item, describe changes, list ports/volumes/envs touched, include screenshots for UI (desktop/VS Code), and `How to verify` steps.

## Security & Configuration
- Do not commit secrets. Use `.env` and compose overrides. Default dev passwords (`vibe`) are for local only.
- Prefer GHCR image names `ghcr.io/<owner>/vdel[:tag]`.

## Agent-Specific Instructions
- Scope: These rules apply repo-wide. Keep patches minimal and scoped.
- Follow the roadmap order in `docs/PR_PLAN.md` and include commands users can run to verify.
