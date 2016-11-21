.PHONY: test dev compile deps gen_migration migrate routes

MIGRATION=

test:
	mix test

dev: migrate
	mix phoenix.server

compile:
	mix compile

deps:
	mix deps.get deps.compile

migrate:
	mix ecto.migrate

gen_migration:
	mix ecto.gen.migration ${MIGRATION}

routes:
	mix phoenix.routes
