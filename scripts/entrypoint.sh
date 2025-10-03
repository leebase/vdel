#!/usr/bin/env bash
set -euo pipefail

# Ensure workspace exists and is writable by developer (uid 1000)
mkdir -p /home/developer/workspace
chown -R 1000:1000 /home/developer /home/developer/workspace || true

# Exec the passed command as developer
exec su -s /bin/bash -c "$*" developer

