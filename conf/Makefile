# Makefile for pinning requirements.

REQ = $(wildcard requirements*.in)
TXT = $(subst .in,.txt,$(REQ))

IDXOPTS = $(addprefix --extra-index-url ,$(INDEXES))
PIPOPTS = --pip-args '$(PIPARGS)'
COMPILE = $(PYTHON) -m piptools compile -v $(IDXOPTS) $(PIPOPTS) $(OPTS)

all: requirements

requirements: $(TXT) ## Build requirements files

upgrade-pkg: ## Upgrade a single package (PKG)
	@ echo Upgrading $(PKG)
	@ touch $(REQ)
	@ $(MAKE) $(TXT) OPTS="$(addprefix -P ,$(PKG))"

upgrade-all: ## Upgrade all packages
	@ echo Upgrading all packages
	@ touch $(REQ)
	@ $(MAKE) $(TXT) OPTS=-U

update-deps: ## Update requirement dependencies
	@ $(PYTHON) requirements.py $(REQ) > requirements.mk

%.txt: %.in constraints.txt
	@ echo Making $@
	@ $(COMPILE) $< -o $@

include config.mk
sinclude requirements.mk
