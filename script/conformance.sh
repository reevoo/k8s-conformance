#!/bin/bash
set -u -e

export KUBERNETES_PROVIDER=skeleton
export KUBERNETES_CONFORMANCE_TEST=y
export KUBECONFIG=/kubeconfig

GINKGO_PARALLEL=y GINKGO_PARALLEL_NODES=8 go run hack/e2e.go -- -v --test --test_args="--ginkgo.focus=\[Conformance\] --ginkgo.skip=\[Serial\]"
go run hack/e2e.go -- -v --test --test_args="--ginkgo.focus=\[Serial\].*\[Conformance\]"
