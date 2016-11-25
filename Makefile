.PHONY:

SH = ./scripts
K  = kubectl


all: | install configure start

configure:
	$(SH)/minikube-configure.sh
	$(SH)/dnsmasq-configure.sh

start:
	$(K) apply -f platform/
	minikube dashboard
	open http://ghost.dev

install:
	$(SH)/minikube-install.sh
	$(SH)/dnsmasq-install.sh
	$(SH)/kubectl-install.sh
	$(SH)/xhyve-install.sh

