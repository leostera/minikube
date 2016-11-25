#!/bin/bash

brew install dnsmasq
echo address=/dev/`minikube ip` > /usr/local/etc/dnsmasq.conf
sudo brew services restart dnsmasq
sudo mkdir -p /etc/resolver
echo nameserver 127.0.0.1 | sudo tee /etc/resolver/dev
