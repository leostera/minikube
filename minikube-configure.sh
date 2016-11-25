#!/bin/bash

minikube config set vm-driver xhyve
minikube start \
  --container-runtime=rkt \
  --iso-url https://github.com/coreos/minikube-iso/releases/download/v0.0.5/minikube-v0.0.5.iso
