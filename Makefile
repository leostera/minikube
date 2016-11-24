.PHONY: minikube xhyve

all:
	./minikube-install.sh
	./minikube-configure.sh
	./xhyve.sh
