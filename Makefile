.PHONY:

all:
	./minikube-install.sh
	./minikube-configure.sh
	./xhyve.sh
	./dnsmasq.sh
	./kubectl-install.sh
	kubectl apply -f default-backend.yml
	kubectl apply -f ghost.yml
	open http://ghost.dev
