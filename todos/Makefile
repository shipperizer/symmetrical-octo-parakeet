.PHONY: test dev compile deps gen_migration routes

MIGRATION=

test:
	mix test

dev:
	mix phoenix.server

compile:
	mix compile

deps:
	mix deps.get deps.compile

gen_migration:
	mix ecto.gen.migration ${MIGRATION}

routes:
	mix phoenix.routes
