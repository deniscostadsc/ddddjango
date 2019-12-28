PHONY: \
	build-ci-image \
	check-code-format \
	format-code \
	lint \
	run \
	test

build-ci-image:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .

check-code-format: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci black --check --line-length=80 .

format-code: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci black --line-length=80 .

lint: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci flake8

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up

test: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci pytest
