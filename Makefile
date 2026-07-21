# vix — Tony's neovim setup.  Single source of truth for getting a
# machine's editor working.  Unlike the sibling repos (zix/clix/rix),
# this repo doesn't need symlinks: cloning it to ~/.config/nvim IS the
# install; these targets handle everything around that.
#
#   make deps      nvim binary + tools + providers (sudo/brew)
#   make setup     plugins, pinned to lazy-lock.json
#   make doctor    check the install and report, loud + colorful
#
# Everything is re-runnable.  `deps` skips the nvim download when the
# pinned version is already installed; `Lazy! restore` converges on the
# lockfile.
#
# NB: written to run on the macOS system make (GNU Make 3.81) as well
# as Debian's — so no .ONESHELL.

SHELL := /bin/bash

VIX          := $(CURDIR)
UNAME_S      := $(shell uname -s)
NVIM_VERSION := v0.12.4

.PHONY: help deps setup doctor

help:
	@echo "vix setup — targets:"
	@echo "  make deps      nvim binary ($(NVIM_VERSION)) + tools + providers"
	@echo "  make setup     install plugins pinned to lazy-lock.json"
	@echo "  make doctor    check the install and report"

# ---- nvim + tools ---------------------------------------------------- #
# Debian: pinned release tarball, arch auto-detected (the Dockerfile
# used to toggle arm64/x86_64 by commenting lines).  macOS: brew.
# python3-neovim / ruby-neovim are the apt provider packages; the node
# provider is best-effort (needs npm, which nodejs owns).
deps:
ifeq ($(UNAME_S),Darwin)
	brew install neovim ripgrep fzf par pandoc
else
	sudo apt-get update -qq -o Acquire::Retries=3
	sudo apt-get install -qq -y -o Acquire::Retries=3 \
	  ripgrep fzf par pandoc curl wget ca-certificates \
	  python3-neovim ruby-neovim
	@if command -v nvim >/dev/null && nvim --version | head -1 | grep -q "$(NVIM_VERSION)"; then \
	  echo "nvim $(NVIM_VERSION) already installed"; \
	else \
	  arch=$$( [ "$$(uname -m)" = "aarch64" ] && echo arm64 || echo x86_64 ); \
	  echo "installing nvim $(NVIM_VERSION) ($$arch)"; \
	  wget -q "https://github.com/neovim/neovim/releases/download/$(NVIM_VERSION)/nvim-linux-$$arch.tar.gz" \
	    -O /tmp/nvim.tar.gz && \
	  sudo tar xzf /tmp/nvim.tar.gz --strip-components=1 -C /usr/local && \
	  rm -f /tmp/nvim.tar.gz; \
	fi
endif
	@if command -v npm >/dev/null; then \
	  npm ls -g neovim >/dev/null 2>&1 || npm i -g neovim \
	    || echo "npm i -g neovim failed — node provider absent (fine)"; \
	else \
	  echo "npm not on PATH — skipping node provider (fine)"; \
	fi

# ---- plugins --------------------------------------------------------- #
# `Lazy! restore` bootstraps lazy.nvim if needed and converges the
# plugin set on exactly what lazy-lock.json pins — deterministic and
# idempotent, unlike a bare headless start (whatever is newest).
setup:
	nvim --headless "+Lazy! restore" +qa
	@echo ""
	@echo "setup complete — run 'make doctor' to verify."

# ---- doctor: report, never mutate ------------------------------------ #
doctor:
	@bash $(VIX)/doctor.sh
