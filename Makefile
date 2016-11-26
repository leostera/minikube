.PHONY:

SH = ./scripts
K  = kubectl


all: | install configure start

configure:
	$(SH)/minikube-configure.sh
	$(SH)/dnsmasq-configure.sh
	cd platform/fluentd && make build

start:
	$(K) apply -f platform/namespaces.yml
	$(K) apply -f platform/fluentd/
	$(K) apply -f platform/
	minikube dashboard
	open http://ghost.dev

stop:
	$(K) delete -f platform/ --now
	$(K) delete -f platform/fluentd/ --now
	$(K) delete pods --all --now

install:
	$(SH)/minikube-install.sh
	$(SH)/dnsmasq-install.sh
	$(SH)/kubectl-install.sh
	$(SH)/xhyve-install.sh

clean:
	$(SH)/clean.sh
