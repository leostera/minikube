.PHONY: build

all: build restart

restart:
	kubectl delete -f fluentd.yml
	kubectl apply  -f fluentd.yml

build:
	docker build -t hub.ostera.io/fluentd $(CURDIR)

clean:
	docker rmi -f hub.ostera.io/fluentd
