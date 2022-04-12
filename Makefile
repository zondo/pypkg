# Makefile for pypkg.

include conf/config.mk

SRCDIR = src
DOCS   = README README.md

REQFILES   = $(wildcard conf/requirements*.txt)
CLEANFILES = build dist venv *.egg* *.el __pycache__ .tox
MAKEFLAGS  = --no-print-directory

PIP = $(PYTHON) -m pip

all: help

# Setup.

venv: ## Set up virtual environment
	$(PYTHON) -m venv venv

dev: ## Set up for developing
	$(PIP) install -U pip
	$(PIP) install $(addprefix -r ,$(REQFILES))
	$(PIP) install -e .

# Packaging.

build: docs ## Build packages
	$(PYTHON) -m build -n $(OPTS)

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

# Uploading to PyPI.

PYPI   = pypi
FILES  = dist/*

upload-check: ## Check uploads
	twine check $(FILES)

upload-test: wheel sdist ## Upload to pypitest
	@ $(MAKE) upload PYPI=pypitest

upload: wheel sdist ## Upload to pypi
	twine upload -r $(PYPI) --skip-existing $(FILES)

# Other targets.

%.md: %
	pandoc -f rst -o $<.md $<

clean: ## Clean up
	find . -name '*.py[co]' | xargs rm
	rm -rf $(CLEANFILES)
