all: \
	build-ci-image \
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

ci: build-ci-image lint test

clean:
	find . -name '*.pyc' | xargs sudo chown ${USER}:${USER}
	find . -name '*.pyc' -delete
	find . -name '__pycache__' | xargs sudo chown -R ${USER}:${USER}
	find . -name '__pycache__' -delete

format-code: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci isort -rc .
	docker run -v $(shell pwd):/code ddddjango-ci black .

lint: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci isort -rc -c .
	docker run -v $(shell pwd):/code ddddjango-ci black --check .
	docker run -v $(shell pwd):/code ddddjango-ci flake8

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up -d

stop:
	docker-compose -f .docker/docker-compose.yml stop

test: build-ci-image
	docker run -v $(shell pwd):/code ddddjango-ci pytest
