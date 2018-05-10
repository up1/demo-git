GOFILES = $(shell find . -name '*.go' -not -path './vendor/*')
GOPACKAGES = $(shell go list ./...  | grep -v /vendor/)

default: build

workdir:
	mkdir -p workdir

build: workdir/demo

build-native: $(GOFILES)
	go build -o workdir/native-demo .

workdir/demo: $(GOFILES)
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o workdir/demo .

test: test-all

test-all:
	@go test -v $(GOPACKAGES)
