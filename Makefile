.PHONY: test dev compile

test:
	mix test

setup:
	mix ecto.setup

dev:
	mix ecto.migrate
	mix phoenix.server

compile:
	mix compile
