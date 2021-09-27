# Common config stuff.

# Detect operating system.
OS = $(shell uname)

ifeq (${OS}, Linux)
PYTHON = python3
OSNAME = linux
LINUX = true
else ifeq (${OS}, Darwin)
PYTHON = python3
OSNAME = mac
MAC = true
else ifeq (${OS}, Msys)
PYTHON = py -3
OSNAME = windows
WINDOWS = true
endif

help: ## This help message
	@ echo "Usage: make [target]"
	@ echo
	@ grep -h ":.*##" $(MAKEFILE_LIST) | grep -v 'sed -e' | \
	  sed -e 's/:.*##/:/' | column -t -s:
