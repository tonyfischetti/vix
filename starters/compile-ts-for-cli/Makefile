
SHEBANG   := \#!/usr/bin/env node
FT 		    := // vi: ft=javascript

BINDIR    := bin
SRCDIR    := src
BUILDDIR  := build

EXENAME   := my-exe
SRCSTEM   := main
SRCFILE   := $(SRCSTEM).ts

SRC       := $(SRCDIR)/$(SRCFILE)
EXE       := $(BINDIR)/$(EXENAME)

$(EXE): $(SRC) Makefile tsconfig.json package.json
	npm run build; mkdir -p bin
	echo "$(SHEBANG)" > $@
	echo "$(FT)" >> $@
	cat build/$(SRCSTEM).js >> $@
	chmod +x $(EXE)

.PHONY: clean
clean:
	rm -rf build
	rm -rf bin

