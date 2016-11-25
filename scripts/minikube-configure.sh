#!/bin/bash

minikube config set vm-driver xhyve
minikube config set cpus $(( `sysctl -n hw.ncpu` - 1 ))
minikube config set memory 8000
minikube start \
  --iso-url https://github.com/coreos/minikube-iso/releases/download/v0.0.5/minikube-v0.0.5.iso
eval $(minikube docker-env)
