#!/bin/bash

eval $(minikube docker-env)

pushd platform/fluentd
  make build
popd
