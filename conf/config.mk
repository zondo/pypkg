# Makefile for system configuration variables.

# Operating system.
OS = $(shell uname -o)

# OS and drive variables.
ifeq (${OS}, GNU/Linux)
PYTHON = python3
OSNAME = linux
LINUX = true
endif

ifeq (${OS}, Msys)
PYTHON = py -3
OSNAME = windows
WINDOWS = true
endif
