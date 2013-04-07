##
# Paths
CWD = .

##
# List of directories that need to be writeable
CHMOD_757_DIRS = $(CWD)/tmp/smarty/*/* $(CWD)/logs

##
# Targets

# default target:
default: chmod cfg

# set appropriate directory permissions:
chmod:
	@@chmod 757 $(CHMOD_757_DIRS)

# local configuration files:
cfg: $(CWD)/cfg/env.php $(CWD)/cfg/local.php

$(CWD)/cfg/%:
	@@echo "Copying [$(CWD)/skel/$@ -> ./$@]"
	@@cp $(CWD)/skel/$@ ./$@

# help:
help:
	@@echo ""
	@@echo "Usage: make [<target>]"
	@@echo "If no target specified, \"default\" is assumed."
	@@echo ""
	@@echo "Available targets:"
	@@echo " chmod    - set appropriate directory permissions"
	@@echo " cfg      - create required local config files, if missing"
	@@echo " help     - show this help"
	@@echo ""

.PHONY: default chmod cfg help
