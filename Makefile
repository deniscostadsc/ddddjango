PHONY: buildciimage checkcodeformat formatcode lint run test

buildciimage:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .

checkcodeformat: buildciimage
	docker run -v $(shell pwd):/code ddddjango-ci black --check --line-length=80 .

formatcode: buildciimage
	docker run -v $(shell pwd):/code ddddjango-ci black --line-length=80 .

lint: buildciimage
	docker run -v $(shell pwd):/code ddddjango-ci flake8

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up

test: buildciimage
	docker run -v $(shell pwd):/code ddddjango-ci pytest
