PHONY: run test lint formatcode

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up

test:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .
	docker run -v $(shell pwd):/code ddddjango-ci pytest

lint:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .
	docker run -v $(shell pwd):/code ddddjango-ci flake8

formatcode:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .
	docker run -v $(shell pwd):/code ddddjango-ci black .
