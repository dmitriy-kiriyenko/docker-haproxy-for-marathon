NAME = donal/docker-haproxy-for-marathon

.PHONY: all build

all: build

build:
	docker build -t $(NAME) .

inspect:
	docker run -i -t --rm $(NAME) /bin/bash

run:
	docker run -i -t --rm $(NAME)

release:
	docker push $(NAME)
