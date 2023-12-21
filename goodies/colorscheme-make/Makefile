
.DELETE_ON_ERROR:

## INSTALL should place in ~/.config/nvim/colors/

# COMPTYPE  := debug

INCDIR    := include
SRCDIR    := src
DOCDIR    := docs
BUILDDIR  := build
TARGETDIR := target

CC        := gcc
CXX       := g++
CFLAGS    := -O2 -Wall -Wextra -I.
CXXFLAGS  := -std=c++2b -O2 -I. -Wall -Wextra -Werror -Wpedantic -Wshadow
CXXFLAGS  += -Wconversion -Wsign-conversion -Wunreachable-code
CXXFLAGS  += -Weffc++ -Wmissing-braces -Wnon-virtual-dtor #-Winline
CXXFLAGS  += -Wnormalized -Wold-style-cast -Wrange-loop-construct
CXXFLAGS  += -Wreturn-local-addr -Wredundant-move
CXXFLAGS  += -Wsuggest-override -Wvirtual-inheritance -Wvirtual-move-assign
CXXFLAGS  += -Wuninitialized -Wswitch-enum -Wswitch
ifeq ($(COMPTYPE), debug)
	CXXFLAGS += -fsanitize=address -fsanitize=undefined
endif
CXXFLAGS  += -I$(INCDIR)
CPPFLAGS  :=
LDFLAGS   :=
LDLIBS    := -lsystemd -lfmt

EXE       := to-vim
# SRCS      := $(wildcard $(SRCDIR)/*.cpp $(SRCDIR)/*.c)
# OBJS      := $(notdir $(patsubst %.cpp, %.o, $(SRCS)))
# DESTOBJS  := $(addprefix $(BUILDDIR)/, $(OBJS))
# RAWDOCS   := $(notdir $(wildcard $(DOCDIR)/*.md))
# DESTDOCS  := $(patsubst %.md, %.pdf, $(addprefix $(TARGETDIR)/$(DOCDIR)/, $(RAWDOCS)))
# DEPS      := $(wildcard $(INCDIR)/*.h) # leaving out the hpp files

SCHDIR    := schemes
OUTVS     := vimscript
SCHEMES   := $(addprefix $(OUTVS)/, $(patsubst %.json, %.vim, $(notdir $(wildcard $(SCHDIR)/*.json))))


.PHONY: all clean mrproper dist check test install begin help done verify show

all: begin install done


$(OUTVS)/%.vim: $(SCHDIR)/%.json $(EXE)
	@mkdir -p $(OUTVS)
	$(info [*] generating		{ $@ })
	@./$(EXE) $< > $@


$(EXE): $(EXE).cpp
	$(info [*] compiling		{ $@ })
	@$(CXX) -o $@ $< $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLIBS)

install: $(SCHEMES)
	$(info [•] installing updated colorschemes)
	cp $(OUTVS)/*.vim ../../colors

begin:
	@echo "$$(tput bold)$$(tput setaf 3)Generating colorscheme files$$(tput sgr0)"
	@printf "\n"

help:
	@echo "P.S. I Love You"

done:
	@printf '\n'
	@echo "$$(tput bold)$$(tput setaf 2)[•] Build done!$$(tput sgr0)"

verify:
	@read -p "Are you sure? [y/N] " resp && resp=$${resp:-1} ; \
	if [ $${resp} != y ] && [ $${resp} != Y ]; then \
		echo "bailing out..." ; \
		exit 1 ; \
	fi

clean:
	rm -f $(EXE)
	rm -rf $(OUTVS)

