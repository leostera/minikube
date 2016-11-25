#!/bin/bash

minikube config set vm-driver xhyve
minikube config set cpus $(( `getconf _NPROCESSORS_ONLN` - 1 ))
minikube config set memory 8000
minikube start \
  --container-runtime=rkt \
  --iso-url https://github.com/coreos/minikube-iso/releases/download/v0.0.5/minikube-v0.0.5.iso
