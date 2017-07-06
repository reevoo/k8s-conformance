K8S_VERSION := $(shell script/k8s-version)
IMAGE ?= quay.io/reevoo/k8s-conformance:$(K8S_VERSION)
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
CONFIG ?= $(ROOT_DIR)/tmp/kubeconfig
.PHONY: $(CONFIG)

conformance: build $(CONFIG)
	docker run --rm --name k8s-conformance --net=host -v $(CONFIG):/kubeconfig $(IMAGE)

build:
	docker build -t $(IMAGE) --build-arg K8S_VERSION=$(K8S_VERSION) .

$(CONFIG):
	kubectl config view --minify > $(CONFIG)

show-config: $(CONFIG)
	cat $(CONFIG)
