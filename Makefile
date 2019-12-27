PHONY: run test

run:
	docker-compose -f .docker/docker-compose.yml build
	docker-compose -f .docker/docker-compose.yml up

test:
	docker build -f .docker/Dockerfile-ci -t ddddjango-ci .
	docker run ddddjango-ci 'pytest'
