# Build & Publish

This repo uses Docker with a minimal placeholder service in PR 02. Use these steps to build locally and publish to GHCR.

## Prerequisites
- Docker 24+ and Compose v2 (`docker compose version`)
- GitHub account with GHCR access

## Image Coordinates
- Default image: `ghcr.io/<owner>/vdel:latest`
- Set your owner when building/pushing:
  ```sh
  export OWNER=<your-gh-username>
  export IMAGE=ghcr.io/$OWNER/vdel
  export TAG=latest
  ```

## Local Build
```sh
make build OWNER=$OWNER TAG=$TAG
# Optional: run placeholder via compose
make up OWNER=$OWNER TAG=$TAG
# Validate page
curl -fsS http://localhost:8080 | grep -q "VDEL placeholder OK" && echo OK
```

## Publish to GHCR
```sh
# One-time login (Personal Access Token or fine-grained token with packages:write)
export GHCR_TOKEN=<token>
make login-ghcr OWNER=$OWNER GHCR_TOKEN=$GHCR_TOKEN
make push OWNER=$OWNER TAG=$TAG
```

## CI/CD (GitHub Actions)
- Workflow: `.github/workflows/build.yml`
- On pushes to `main`, tags `latest` and `sha` and pushes to `ghcr.io/${owner}/vdel` with build cache reuse.

## Troubleshooting
- Compose not found: upgrade Docker Desktop or install Compose v2.
- Push denied: ensure `OWNER` is correct and token has `packages:write`.
- Port busy: stop other services binding `:8080` before `make up`.
