# VDEL — Vibe Data Engineer Linux

A Docker-first Linux environment designed for data engineers.  
Runs as a single container and exposes a **web desktop** (via noVNC) and **VS Code in the browser** (via code-server).  
Preloaded with the core toolbelt for database development — with Snowflake support as a first-class citizen.

---

## Features

- **Web Desktop (XFCE + noVNC)** — access at `http://localhost:8080`
- **VS Code in Browser (code-server)** — access at `http://localhost:8443`
- **Snowflake Tools**
  - Snowflake CLI (`sf`)
  - Snowflake Python connector
  - dbt-snowflake
  - sqlfluff (Snowflake dialect)
- **Database Clients**
  - DBeaver CE (universal GUI)
  - DuckDB, SQLite, PostgreSQL client, MySQL client
- **Data Stack**
  - Python 3, pandas, polars, pyarrow
  - JupyterLab for notebooks
- **Developer Basics**
  - git, curl, wget, make, build tools
  - non-root `developer` user with persistent workspace volume

---

## Quick Start

```bash
# clone repo
git clone https://github.com/<your-username>/vdel.git
cd vdel

# build & run
docker compose up -d

	•	Open web desktop → http://localhost:8080
(default password: vibe)
	•	Open VS Code → http://localhost:8443
(default password: vibe)

Workspace persists under the vdel_home volume.

⸻

Snowflake Setup

Inside VS Code terminal or desktop terminal:

# Add a connection
sf connection add myconn \
  --account <acct> \
  --user <user> \
  --auth-type externalbrowser

# Run a quick test
sf sql -c myconn -q "select current_user(), current_account();"

Then:
	•	Use dbt for modeling (dbt init inside ~/workspace)
	•	Open DBeaver from the desktop for GUI access

⸻

Roadmap
	•	Streamlit-based launcher dashboard
	•	Pre-scaffolded dbt project & example notebooks
	•	Variants: lite, standard, full
	•	CI/CD with GitHub Actions (build → GHCR)

⸻

License

MIT — free to use, modify, and share.

⸻

Contributing

Pull requests welcome! See CONTRIBUTING.md for guidelines.

---
