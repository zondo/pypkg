# Makefile for pypkg.

include conf/Makefile.conf

SOURCES = pypkg.py
DOCS    = README README.md

SETUP  = $(PYTHON) setup.py

PYPI   = pypi
CHECK  = twine check $(FILES)
UPLOAD = twine upload -r $(PYPI) --skip-existing $(FILES)
FILES  = dist/*

CLEANFILES = build dist *.egg* *.zip *.el __pycache__ .tox

MAKEFLAGS = --no-print-directory

all: develop

develop:
	pip install -e .

check:;	$(CHECK)

wheel sdist:
	$(SETUP) $@ $(OPTS)

upload:	docs wheel sdist
	$(UPLOAD)

upload-test: wheel sdist
	@ $(MAKE) upload PYPI=pypitest

verify:	test flake

test:
	$(PYTHON) -m pytest -v

flake:
	flake8 $(SOURCES)

docs: $(DOCS)

%.md: %
	pandoc -f rst -o $<.md $<

clean:
	$(SETUP) $@
	find . -name '*.py[co]' | xargs rm
	rm -rf $(CLEANFILES)
