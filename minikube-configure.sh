#!/bin/bash

minikube config set vm-driver xhyve
kubectl apply -f default-backend.yml
