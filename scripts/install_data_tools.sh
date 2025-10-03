#!/usr/bin/env bash
set -euo pipefail

# Installs system and Python-level data tools.

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ca-certificates curl git build-essential \
  python3 python3-pip python3-venv python-is-python3 \
  sqlite3 postgresql-client default-mysql-client \
  less nano

apt-get clean && rm -rf /var/lib/apt/lists/*

# Python tooling (user install for developer)
su - developer -c 'python -m pip install --user --break-system-packages --no-cache-dir --upgrade pip'
su - developer -c 'python -m pip install --user --break-system-packages --no-cache-dir -r /opt/requirements.txt'

# Provide sf alias if only 'snow' is present
ln -sf /home/developer/.local/bin/snow /usr/local/bin/sf || true

echo "Toolbelt installation complete."
