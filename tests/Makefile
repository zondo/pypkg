# Makefile for unit tests.

include ../conf/config.mk

# TODO: customize this file

PKG    = pypkg
RUN    = $(PYTHON) -m pytest $(OPTS) $(ARGS)
COVER  = --cov $(PKG) --cov-config=$(CFG) $(addprefix --cov-report , $(REPORT))
PROF   = --profile
CFG    = ../setup.cfg
REPORT = term html

CLEANFILES = .coverage htmlcov prof __pycache__

.DEFAULT:; @ $(MAKE) test TEST=test-$@.py

all: help

test: ## Run tests with coverage
	@ echo running unit tests
	@ $(RUN) $(COVER) $(TEST)

profile: ## Run tests with profiling
	@ echo running tests with profiling
	@ $(RUN) $(PROF) $(TEST)

clean: ## Clean up
	rm -rf $(CLEANFILES)
