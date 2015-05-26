VERSION=3.91

build:
	rm -rf release
	docker build -t upx-bin build
	docker run --rm -v $(shell pwd)/release:/release upx
	docker build -t lalyos/upx .

deps:
	go get github.com/progrium/gh-release

release: build
	gh-release create lalyos/docker-upx $(VERSION)

.PHONY: build
