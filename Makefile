.PHONY: all clean
.PHONY: run kill list
.PHONY: manifests get apply delete

include envvars
export $(shell sed 's/=.*//' envvars)

K = kubectl --namespace=svt
K_OPTS = --now
EXEC_OPTS ?= -ti

SCRIPTS = ./scripts

TEMPLATES = $(shell find templates -name "*.yml")
MANIFESTS = $(TEMPLATES:templates/%.yml=manifests/%.yml)
APPLIES   = $(TEMPLATES:templates/%.yml=apply-%)
DELETES   = $(TEMPLATES:templates/%.yml=delete-%)
TYPES     = $(shell grep kind templates/* | cut -d' ' -f2 | sort | uniq)
GETS      = $(TYPES:%=get-%)

all: apply

clean:
	rm -rf manifests/*

purge: delete kill

kill:
	$(K) delete pods $(K_OPTS)

list:
	$(K) get pods $(LIST_OPTS)

exec:
	@$(K) exec $(EXEC_OPTS) $(POD_NAME) -- $(CMD)

# Kubernetes Helpers
available-capacity: nodes.json
	$(SCRIPTS)/current-usage.rb | jq '.[] | [.name,.instance_type,.available.cpu,.available.memory] | @csv' | sed 's/[\\"]//g' | column -s, -t | sort

nodes.json: FORCE
	$(K) get nodes -o json > nodes.json

# Porcelain
apply: $(APPLIES)
delete: $(DELETES)
get: $(GETS)
manifests: $(MANIFESTS)

# Plumbing
get-%:
	$(K) get $*

attach-%:
	$(K) attach -ti $*

describe-%:
	$(K) describe pod $*

manifests/%.yml: templates/%.yml .envvars FORCE
	envsubst '$(shell cat .envvars)' < $< > $@

.envvars: envvars
	@echo "Magically getting envvars to replace..."
	@cat envvars \
		| cut -d' ' -f1 \
		| sort \
		| uniq \
		| grep -v -e "^#" -e "^$$" \
		| sed 's/\(.*\)/$${\1}/' \
		| xargs > .envvars

apply-%: manifests/%.yml
	$(K) apply -f $<

delete-%:
	$(K) delete -f manifests/$*.yml $(K_OPTS)

kill-%:
	$(K) delete pod $* $(K_OPTS)

FORCE:
