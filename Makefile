PREFIX ?= $(HOME)/.local

BIN = $(PREFIX)/bin
MAN = $(PREFIX)/share/man

SCRIPTS = $(shell ls *.sh)
MANUALS = $(shell ls *.pod)
BIN_TARGETS = $(addprefix $(BIN)/,$(SCRIPTS:.sh=))
MAN_TARGETS = $(addprefix $(MAN)/man1/,$(MANUALS:.pod=.1))

check:
	shellcheck $(SCRIPTS)

install: $(BIN_TARGETS) $(MAN_TARGETS)

.PHONY: check install

$(BIN)/%: %.sh $(BIN)
	install $< $@

$(MAN)/man1/%.1: %.pod $(MAN)/man1
	pod2man --release '$(*) $(shell ./$(*).sh --version 2> /dev/null || echo [unversioned])' \
	        --center 'User Commands Manual' $< > $@

$(MAN)/man1: $(MAN)
	mkdir $@
