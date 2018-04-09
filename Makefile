IMAGE := panubo/hugo

build:
	docker build -t $(IMAGE):latest .
