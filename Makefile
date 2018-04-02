VERSION ?= 3.94
REPO    ?= lalyos/upx

build:
	docker build -t $(REPO):$(VERSION) .
