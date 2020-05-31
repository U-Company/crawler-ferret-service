default: compile start

compile:
	go build -o=./bin/worker ./main.go

start:
	./bin/worker

release:
ifeq ($(RELEASE_VERSION), )
	$(error "Release version is required (version=x)")
else ifeq ($(GITHUB_TOKEN), )
	$(error "GitHub token is required (GITHUB_TOKEN)")
else
	rm -rf ./dist && \
	git tag -a v$(RELEASE_VERSION) -m "New $(RELEASE_VERSION) version" && \
	git push origin v$(RELEASE_VERSION) && \
	goreleaser
endif


PYTHONPATH=.
SCRIPTS=scripts/
TESTS_UNIT=abc_storage/tests/
TESTS_INTEGRATION=tests/
REQUIREMENTS=requirements
DOCKER_COMPOSE_FULL=deployments/docker-compose.full.yml
DOCKER=docker

ifndef PYTHON
	PYTHON=python
endif
ifndef DOCKER_COMPOSE
	DOCKER_COMPOSE=docker-compose
endif
ifndef PYTEST
	PYTEST=pytest
endif
ifndef PIP
	PIP=pip
endif
ifndef TEST_SUBFOLDER
	TEST_SUBFOLDER=./
endif
ifndef VAULT_ENV
	VAULT_ENV=LOCAL
endif

ENVS=PYTHONPATH=${PYTHONPATH} ENV_FILE=${ENV_FILE}

.PHONY: publish clean build deps



deps:
	$(info $(ENVS))
	$(PIP) install -r $(REQUIREMENTS)

build:
	$(PYTHON) setup.py bdist_wheel
	$(DOCKER) build -t crawler-parser-service .

publish:
	$(DOCKER) login 84.201.142.193:5000
	$(DOCKER) tag $(TAG) 84.201.142.193:5000/crawler-parser-service:$(VERSION)
	$(DOCKER) push 84.201.142.193:5000/crawler-parser-service:$(VERSION)

clean:
	$(info $(ENVS))
	rm -rf build/
	rm -rf dist/
	rm -rf abc_storage.egg-info
