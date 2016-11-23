.PHONY: test dev compile deps gen_migration migrate routes

MIX_ENV?=dev
MIGRATION=

test:
	mix test

dev: migrate
	MIX_ENV=$(MIX_ENV) mix phoenix.server

compile:
	mix compile

deps:
	mix deps.get deps.compile

migrate:
	MIX_ENV=$(MIX_ENV) mix ecto.migrate

gen_migration:
	mix ecto.gen.migration ${MIGRATION}

routes:
	mix phoenix.routes
