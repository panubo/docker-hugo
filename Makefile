NAME       := hugo
TAG        := $(shell sed -E -e '/HUGO_VERSION[ |=]/!d' -e 's/.*HUGO_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)
IMAGE_NAME := panubo/$(NAME)

.PHONY: build push clean
build:
	docker build --pull -t $(IMAGE_NAME):$(TAG) .
	docker build --pull -t $(IMAGE_NAME):$(TAG)-extended -f Dockerfile.extended .

push:
	docker push $(IMAGE_NAME):$(TAG)
	docker push $(IMAGE_NAME):$(TAG)-extended

clean:
	docker rmi $(IMAGE_NAME):$(TAG) || true
	docker rmi $(IMAGE_NAME):$(TAG)-extended || true
