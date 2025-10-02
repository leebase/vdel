# Desktop & IDE Services

This PR adds a temporary multi-service setup to validate the desktop (noVNC) and VS Code (code-server). These will converge into a single container in a later PR.

## Endpoints
- Desktop (noVNC): `http://localhost:8080`
- VS Code (code-server): `http://localhost:8443`

## Credentials
- VNC/desktop password: `VNC_PASSWORD` (default: `vibe`)
- code-server password: `CODE_SERVER_PASSWORD` (default: `vibe`)

## Volumes
- `vdel_home` → mounted as workspace inside services
- `vdel_codeserver` → persists code-server data (extensions, settings)

## Run
```sh
# Optional: populate .env
cp -n .env.example .env

# Start services
make up OWNER=$OWNER

# Validate
curl -fsS http://localhost:8080 >/dev/null && echo "Desktop OK (web UI reachable)"
curl -fsS http://localhost:8443 >/dev/null && echo "code-server OK (login page reachable)"

# Stop
make down
```

Note: This is a stepping-stone toward the single-container goal described in the roadmap.
