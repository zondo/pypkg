# Common config stuff.

PYTHON = python3

# Get the host system.
SYSCMD = import platform; print(platform.system())
SYSTEM = $(shell python -c "$(SYSCMD)")

# Get makefile help text.
export SHOW_HELP
define SHOW_HELP

import re, sys
text = sys.stdin.read()
pattern = r"^([a-zA-Z_-]+):.*?## (.*)"
for match in re.finditer(pattern, text, re.M):
    print("%-15s %s" % match.groups())

endef

help: ## This help message
	@ cat $(MAKEFILE_LIST) | python -c "$$SHOW_HELP"
