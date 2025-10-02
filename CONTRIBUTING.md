# Contributing to VDEL

Thanks for your interest in contributing! This repo ships a Docker-first data engineering desktop (web desktop + code-server) with Snowflake-first tooling.

## How We Work
- Roadmap: See `docs/PR_PLAN.md` and tackle items in sequence.
- Branches: `feat/*`, `fix/*`, `docs/*` (short-lived, rebased on `main`).
- Commits: Conventional style, e.g., `feat(desktop): add noVNC service` (<=72 chars).
- PRs: Use `.github/pull_request_template.md`, link the roadmap line, and include exact verification steps.

## Development
- Build/Run (when available): `docker compose up -d`, `docker compose down`.
- Keep patches minimal and scoped; prefer small, focused PRs.
- Do not commit secrets. Use `.env` and local overrides.

## Style & Tools
- Follow repo-wide guidance in `AGENTS.md` for Dockerfile/YAML/shell/Python.
- Recommended linters: `hadolint`, `yamllint`, `shellcheck`, `shfmt`, `black`.

## Reporting Issues
- Include environment, steps to reproduce, and expected vs. actual behavior.

## Getting Help
- Read `README.md` for goals and quick start.
- Reference acceptance criteria in `docs/PR_PLAN.md` as your checklist.
