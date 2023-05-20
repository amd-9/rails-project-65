setup:
	bin/setup

start:
	bin/rails s -p "3000" -b "0.0.0.0"

build-assets:
	yarn install
	yarn build 
	yarn build:css
	bin/rails assets:precompile 

build:
	make setup
	make build-assets

start-railway:
	make build-assets
	bin/rails db:migrate
	bin/rails s -p ${PORT} -b "0.0.0.0"

install:
	bundle install

console:
	bin/rails console

test:
	bin/rails test

test-system:
	bin/rails test:system

lint:
	rubocop
	slim-lint app/**/*.slim

lint-fix:
	rubocop -A

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:schema:load
	bin/rails db:migrate
	bin/rails db:fixtures:load

.PHONY: test