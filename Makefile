SHELL := /bin/sh

# Image settings
OWNER ?= your-gh-username
IMAGE ?= ghcr.io/$(OWNER)/vdel
TAG   ?= latest

DOCKER  ?= docker
COMPOSE ?= docker compose

.PHONY: help build push up down logs tag login-ghcr clean lint update-toolbelt jupyter

help:
	@echo "Targets:"
	@echo "  make build          # Build $(IMAGE):$(TAG)"
	@echo "  make push           # Push $(IMAGE):$(TAG)"
	@echo "  make up             # Compose up (detached)"
	@echo "  make down           # Compose down"
	@echo "  make logs           # Tail vdel logs"
	@echo "  make tag VERSION=x  # Tag built image with VERSION"
	@echo "  make login-ghcr     # Login to GHCR using GHCR_TOKEN env"
	@echo "  make lint           # Run sqlfluff version check"
	@echo "  make update-toolbelt# Update Python toolbelt in vdel"
	@echo "  make jupyter        # Start JupyterLab on :8888"

build:
	$(DOCKER) build -t $(IMAGE):$(TAG) .

push:
	$(DOCKER) push $(IMAGE):$(TAG)

up:
	IMAGE=$(IMAGE):$(TAG) $(COMPOSE) up -d

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f vdel

tag:
	@test -n "$(VERSION)" || (echo "VERSION is required. e.g., make tag VERSION=v0.1.0" && exit 1)
	$(DOCKER) tag $(IMAGE):$(TAG) $(IMAGE):$(VERSION)

login-ghcr:
	@test -n "$(GHCR_TOKEN)" || (echo "Set GHCR_TOKEN env (a GHCR PAT) and OWNER before running." && exit 1)
	$(DOCKER) login ghcr.io -u $(OWNER) -p $(GHCR_TOKEN)

clean:
	-$(DOCKER) image rm $(IMAGE):$(TAG) 2>/dev/null || true

lint:
	IMAGE=$(IMAGE):$(TAG) $(COMPOSE) run --rm vdel sqlfluff --version

update-toolbelt:
	IMAGE=$(IMAGE):$(TAG) $(COMPOSE) run --rm vdel bash -lc 'python -m pip install -U -r /opt/requirements.txt'

jupyter:
	IMAGE=$(IMAGE):$(TAG) $(COMPOSE) exec -d vdel bash -lc 'cd /home/developer/workspace && exec su -s /bin/bash -c "jupyter lab --ServerApp.root_dir=/home/developer/workspace --no-browser --ip 0.0.0.0 --port 8888 --IdentityProvider.token= --ServerApp.password=" developer'
