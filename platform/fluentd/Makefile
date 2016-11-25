.PHONY: build

all: build
	kubectl delete -f fluentd.yml
	kubectl apply  -f fluentd.yml

build:
	docker build -t hub.ostera.io/fluentd .

clean:
	docker rmi -f hub.ostera.io/fluentd
