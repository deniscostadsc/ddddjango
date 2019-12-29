all: \
	build-ci-image \
	check-code-format \
	ci \
	clean \
	format-code \
	lint \
	run \
	stop \
	test
.PHONY: all

build-ci-image:
	docker build -f .docker/ci.Dockerfile -t ddddjango-ci .

check-code-format: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci black --check --line-length=80 .

ci: build-ci-image check-code-format lint test

clean:
	sudo chown -R ${USER}:${USER} . # docker create files as root
	find . -name '*.pyc' -delete
	find . -name '*.pyo' -delete
	find . -name '__pycache__' -delete

format-code: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci black --line-length=80 .

lint: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci flake8

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up -d

stop:
	docker-compose -f .docker/docker-compose.yml stop

test: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci pytest
