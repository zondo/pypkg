# Common config stuff.

# Detect operating system.
OS = $(shell uname)

ifeq ($(OS), GNU/Linux)
PYTHON = python3
OSNAME = linux
LINUX = true
else ifeq ($(OS), Darwin)
PYTHON = python3
OSNAME = mac
MAC = true
else ifeq ($(OS), Msys)
PYTHON = python
OSNAME = windows
WINDOWS = true
else
$(error Unknown OS: $(OS))
endif

# Set help column formatting.
ifeq ($(OSNAME), windows)
COLFMT = cat
else
COLFMT = column -t -s:
endif

help: ## This help message
	@ echo "Usage: make [target]"
	@ echo
	@ grep -h ":.*##" $(MAKEFILE_LIST) | grep -v 'sed -e' | \
	  sed -e 's/:.*##/:/' | $(COLFMT)
