commit:
	make fix
	make lint
	make test
	git add .
	git commit

console:
	bundle exec rails console

fix:
	rubocop -A

lint:
	rubocop

setup:
	bundle exec rake db:create
	bundle exec rake db:migrate
	bundle exec rake db:test:prepare
	bundle install
	make fix
	make lint

setup_from_drop_dbs:
	bundle exec rake db:drop
	make setup

test:
	bundle exec rspec

test_compose:
	docker-compose down
	docker-compose up
