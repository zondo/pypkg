# Makefile for pypkg.

# TODO: customize this file

include conf/config.mk

PACKAGE = pypkg
SRCDIR  = src
CONFDIR = conf
TESTDIR = tests
DOCTEST = README.rst
DOCS    = README.rst README.md

REQFILES   = $(subst .in,.txt,$(wildcard $(CONFDIR)/requirements*.in))
CLEANFILES = build dist venv *.egg* __pycache__ .tox
MAKEFLAGS  = --no-print-directory

PIP = $(PYTHON) -m pip

all: help

# Setup.

venv: ## Set up virtual environment
	$(PYTHON) -m venv venv

dev: ## Set up for developing
	$(PIP) install -U pip pip-tools wheel
	@ $(MAKE) -s -C $(CONFDIR) requirements
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

check: test mypy flake black isort safety ## Run all tests

test: ## Run package tests
	@ echo running doctests
	@ $(PYTHON) -m pytest $(DOCTEST)
	@ $(MAKE) -C $(TESTDIR) $@

mypy: ## Run mypy on sources
	mypy $(SRCDIR)

flake: ## Run flake8 on sources
	flake8 $(SRCDIR)

black: ## Run black on sources
	black $(SRCDIR)

isort: ## Run isort on sources
	isort $(SRCDIR)

safety: ## Run package safety check
	@ $(MAKE) -C $(CONFDIR) $@

# Versioning.

BUMPVER  = bump2version --config-file=$(BUMPCONF) --allow-dirty
BUMPCONF = $(CONFDIR)/version.cfg
VERSION  = $(SRCDIR)/$(PACKAGE)/__init__.py

bump-major: ## Bump major version
	@ $(BUMPVER) major $(VERSION)

bump-minor: ## Bump minor version
	@ $(BUMPVER) minor $(VERSION)

bump-patch: ## Bump patch version
	@ $(BUMPVER) patch $(VERSION)

# Release.

PYPI   = pypi
FILES  = dist/*

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
%.md: %.org
	pandoc -o $@ $<

%.rst: %.org
	pandoc -o $@ $<

clean: ## Clean up
	rm -rf $(CLEANFILES)
