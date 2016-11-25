#!/bin/bash

curl -O https://storage.googleapis.com/kubernetes-release/release/v1.4.3/bin/darwin/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version -c
