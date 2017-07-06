# Kubernetes Conformance Tests

### Dependencies:

* docker
* kubectl
* awk

### Instructions:

* Check out this repo

```
git clone git@github.com:reevoo/k8s-conformance.git
cd k8s-conformance
```

* Check that you will be testing the correct cluster:

```
make show-config
```

* run the conformance tests:

```
make
```
