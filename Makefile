# Makefile for pypkg.

include conf/config.mk

PACKAGE = pypkg
SRCDIR  = src
DOCS    = README README.md

REQFILES   = $(subst .in,.txt,$(wildcard conf/requirements*.in))
CLEANFILES = build dist venv *.egg* *.el __pycache__ .tox
MAKEFLAGS  = --no-print-directory

PIP = $(PYTHON) -m pip

all: help

# Setup.

venv: ## Set up virtual environment
	$(PYTHON) -m venv venv

dev: ## Set up for developing
	@ $(MAKE) -s -C conf requirements
	$(PIP) install -U pip
	$(PIP) install $(addprefix -r ,$(REQFILES))
	$(PIP) install -e .

deps: ## Show package dependency tree
	@ pipdeptree -p $(PACKAGE)

# Packaging.

build: docs ## Build packages
	$(PYTHON) -m build -n $(OPTS)
	$(PYTHON) -m build -n -s $(OPTS)

docs: $(DOCS) ## Update doc files

# Testing.

check: test flake black isort ## Run all tests

test: ## Run package tests
	$(PYTHON) -m pytest -v

flake: ## Run flake8 on sources
	flake8 $(SRCDIR)

black: ## Run black on sources
	black $(SRCDIR)

isort: ## Run isort on sources
	isort $(SRCDIR)

# Release.

PYPI   = pypi
FILES  = dist/*

# FIXME: add changelog support

BUMPVER  = bump2version --config-file=$(BUMPCONF) --allow-dirty
BUMPCONF = conf/version.cfg
VERSION  = $(SRCDIR)/$(PACKAGE)/__init__.py

bump-major: ## Bump major version
	@ $(BUMPVER) major $(VERSION)

bump-minor: ## Bump minor version
	@ $(BUMPVER) minor $(VERSION)

release-check: ## Check release
	@ make build
	check-wheel-contents dist/*.whl

upload-check: ## Check uploads
	twine check $(FILES)

upload-test: upload-check ## Upload to pypitest
	@ $(MAKE) upload PYPI=pypitest

upload: upload-check ## Upload to pypi
	twine upload -r $(PYPI) --skip-existing $(FILES)

# Other targets.

%.md: %
	pandoc -f rst -o $<.md $<

clean: ## Clean up
	find . -name '*.py[co]' | xargs rm
	rm -rf $(CLEANFILES)
