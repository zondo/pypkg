# Makefile for pypkg.

include conf/config.mk

SOURCES = pypkg.py
DOCS    = README README.md

CLEANFILES = build dist *.egg* *.el __pycache__ .tox
MAKEFLAGS  = --no-print-directory

TOOLS = pip-tools build twine flake8 mypy

all: help

dev: ## Set up for developing
	pip install -e .

# Packaging.

build: docs ## Build packages
	$(PYTHON) -m build $(OPTS)

docs: $(DOCS) ## Update doc files

# Testing.

check: test flake mypy ## Run all tests

test: ## Run package tests
	$(PYTHON) -m pytest -v

flake: ## Run flake8 on sources
	flake8 $(SOURCES)

mypy: ## Run mypy on sources
	mypy $(SOURCES)

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

tools: ## Install dev tools
	pip install $(OPTS) $(TOOLS)

%.md: %
	pandoc -f rst -o $<.md $<

clean: ## Clean up
	find . -name '*.py[co]' | xargs rm
	rm -rf $(CLEANFILES)
