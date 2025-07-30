setup:
	bin/setup

install:
	bundle install

console:
	bin/rails console

start:
	bin/rails s -p "3000" -b "0.0.0.0"

lint:
	rubocop

lint-fix:
	rubocop -A

db-migrate:
	bin/rails db:migrate

.PHONY: test