PREFIX ?= ~/.local/bin

SCRIPTS = $(shell ls *.sh)
TARGETS = $(addprefix $(PREFIX)/,$(SCRIPTS:.sh=))

install: $(TARGETS)

$(PREFIX)/%: %.*
	install $< $@
