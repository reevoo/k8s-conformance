FROM golang:1.8.3
MAINTAINER Reevoo Devops <devops@reevoo.com>
ARG K8S_VERSION

RUN apt-get update && apt-get install -y rsync

RUN mkdir -p /go/src/k8s.io && \
    git clone --depth 1 -b v$K8S_VERSION https://github.com/kubernetes/kubernetes.git /go/src/k8s.io/kubernetes
RUN go get -u github.com/jteeuwen/go-bindata/go-bindata
RUN go get -u k8s.io/test-infra/kubetest

WORKDIR /go/src/k8s.io/kubernetes

RUN make all WHAT=cmd/kubectl && \
    make all WHAT=vendor/github.com/onsi/ginkgo/ginkgo && \
    make all WHAT=test/e2e/e2e.test

COPY conformance.sh /
CMD /conformance.sh
