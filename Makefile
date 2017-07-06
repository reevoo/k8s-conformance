.PHONY: tmp/kubeconfig
K8S_VERSION := $(shell script/k8s-version)
IMAGE ?= quay.io/reevoo/k8s-conformance:$(K8S_VERSION)
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
KUBECONFIG ?= $(ROOT_DIR)/tmp/kubeconfig



conformance: build $(KUBECONFIG)
	docker run --rm --name k8s-conformance --net=host -v $(KUBECONFIG):/kubeconfig $(IMAGE)

build:
	docker build -t $(IMAGE) --build-arg K8S_VERSION=$(K8S_VERSION) .

$(KUBECONFIG):
	kubectl config view --minify > $(KUBECONFIG)

show-config: $(KUBECONFIG)
	cat $(KUBECONFIG)
