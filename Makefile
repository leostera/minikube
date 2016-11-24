.PHONY: minikube xhyve

all:
	./minikube-install.sh
	./minikube-configure.sh
	./xhyve.sh
	./dnsmasq.sh
	kubectl apply -f ghost.yml
	open http://ghost.dev
