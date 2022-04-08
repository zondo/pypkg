# Makefile for unit tests.

include ../conf/config.mk

# TODO: customize this file

PKG    = pypkg
RUN    = $(PYTHON) -m pytest $(OPTS) $(ARGS)
COVER  = --cov $(PKG) --cov-config=coverage.cfg --cov-report $(REPORT)
PROF   = --profile
HTML   = results.html
REPORT = term
OUTPUT = output

CLEANFILES = *.pyc .coverage htmlcov prof __pycache__ $(HTML) $(OUTPUT)

.DEFAULT:; @ $(MAKE) test TEST=test-$@.py

all: help

test: ## Run tests
	$(RUN) $(TEST)

cover: ## Run tests with coverage
	$(RUN) $(COVER) $(TEST)

cover-html: ## Run tests with HTML coverage output
	@ $(MAKE) cover REPORT=html

profile: ## Run tests with profiling
	$(RUN) $(PROF) $(TEST)

clean: ## Clean up
	rm -rf $(CLEANFILES)
