IMAGE    := panubo/hugo
REGISTRY := docker.io
VERSION  := $(shell sed -E -e '/HUGO_VERSION[ |=]/!d' -e 's/.*HUGO_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)

.PHONY: build push
build:
	docker build -t $(IMAGE):latest .

push:
	docker tag $(IMAGE):latest $(REGISTRY)/$(IMAGE):$(VERSION)
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)
