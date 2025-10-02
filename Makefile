SHELL := /bin/sh

# Image settings
OWNER ?= your-gh-username
IMAGE ?= ghcr.io/$(OWNER)/vdel
TAG   ?= latest

DOCKER  ?= docker
COMPOSE ?= docker compose

.PHONY: help build push up down logs tag login-ghcr clean

help:
	@echo "Targets:"
	@echo "  make build          # Build $(IMAGE):$(TAG)"
	@echo "  make push           # Push $(IMAGE):$(TAG)"
	@echo "  make up             # Compose up (detached)"
	@echo "  make down           # Compose down"
	@echo "  make logs           # Tail vdel logs"
	@echo "  make tag VERSION=x  # Tag built image with VERSION"
	@echo "  make login-ghcr     # Login to GHCR using GHCR_TOKEN env"

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

