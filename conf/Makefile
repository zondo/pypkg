# Makefile for pinning requirements.

REQ = $(wildcard requirements*.in)
TXT = $(subst .in,.txt,$(REQ))

COMPILE = $(PYTHON) -m piptools compile -v

all: requirements

requirements: $(TXT)

%.txt: %.in constraints.txt
	@ echo Making $@
	@ $(COMPILE) $< -o $@

include config.mk
