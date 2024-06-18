# Use bash syntax
# Ref:https://askubuntu.com/questions/95365/
SHELL := /bin/bash
-include .env
export $(shell sed 's/=.*//' .env)

DOCKER_DEFAULT_PLATFORM ?= linux/amd64

.EXPORT_ALL_VARIABLES:

.ONESHELL:

.phony:
	help

## ============================================================================
## Help Commands

help: ## Show help
	sed -ne '/sed/!s/## //p' $(MAKEFILE_LIST)

fix: ## Fix Telethon protection
	$(call FUNC_MAKE_INIT) \
	&& rm -rf \
		./config/bot.session

## ============================================================================
## docker Commands

go: ## rm->up->log container image via docker
	$(call FUNC_MAKE_INIT) \
	&& make rm fix up log

up: ## run container
	$(call FUNC_MAKE_INIT) \
	&& docker compose \
	-f ./docker-compose.yml \
	up \
	--detach

log: ## get container log
	$(call FUNC_MAKE_INIT) \
	&& docker compose \
	-f ./docker-compose.yml \
	logs \
	--follow \
	--tail 20

rm: ## rm container
	$(call FUNC_MAKE_INIT) \
	&& docker compose \
	-f ./docker-compose.yml \
	rm \
	--stop \
	--force

shell: ## container instance tty
	$(call FUNC_MAKE_INIT) \
	&& docker compose \
	-f ./docker-compose.yml \
	exec \
	backend \
	bash

define FUNC_MAKE_INIT
	if [ -n "$$(command -v hr)" ]; then hr -; else echo "-----";fi \
	&& echo "⚙️ Running Makefile target: ${MAKECMDGOALS}"
endef

