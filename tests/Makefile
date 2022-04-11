# Makefile for unit tests.

include ../conf/config.mk

# TODO: customize this file

PKG    = pypkg
RUN    = $(PYTHON) -m pytest $(OPTS) $(ARGS)
COVER  = --cov $(PKG) --cov-config=$(CFG) $(addprefix --cov-report , $(REPORT))
PROF   = --profile
CFG    = coverage.cfg
REPORT = term html

CLEANFILES = .coverage htmlcov prof __pycache__

.DEFAULT:; @ $(MAKE) test TEST=test-$@.py

all: help

test: ## Run tests
	$(RUN) $(TEST)

cover: ## Run tests with coverage
	$(RUN) $(COVER) $(TEST)

profile: ## Run tests with profiling
	$(RUN) $(PROF) $(TEST)

clean: ## Clean up
	rm -rf $(CLEANFILES)
