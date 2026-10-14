#!/usr/bin/env bash
# vix doctor — check that this machine's neovim setup works.  Reports
# every piece, never mutates anything, exits nonzero if something is
# wrong.  Invoked by `make doctor`.

VIX="$(cd "$(dirname "$0")" && pwd)"
UNAME_S="$(uname -s)"

green="\033[32m"; red="\033[31m"; yellow="\033[33m"; bold="\033[1m"; off="\033[0m"
fail=0
ok()   { printf "  ${green}✓${off} %s\n" "$1"; }
bad()  { printf "  ${red}✗ %s${off}\n" "$1"; fail=1; }
warn() { printf "  ${yellow}! %s${off}\n" "$1"; }

printf "${bold}vix doctor${off} (%s)\n" "$UNAME_S"

# --- nvim itself ---
pin="$(sed -n 's/^NVIM_VERSION *:= *//p' "$VIX/Makefile")"
if command -v nvim >/dev/null; then
  actual="$(nvim --version | head -1)"
  where="$(command -v nvim)"
  if printf '%s' "$actual" | grep -q "$pin"; then
    ok "nvim is the pinned $pin ($where)"
  elif [ "$UNAME_S" = "Linux" ]; then
    # linux installs the pinned tarball to /usr/local; a different
    # version means a missed upgrade, or something earlier on PATH
    # shadowing it
    if [ "$where" != "/usr/local/bin/nvim" ]; then
      bad "nvim is $actual at $where, not the pinned $pin in /usr/local/bin (shadowed? make deps)"
    else
      bad "nvim is $actual, pin is $pin (make deps)"
    fi
  else
    # macOS gets nvim from brew, which isn't pinned
    warn "nvim is $actual, pin is $pin (brew isn't pinned; fine)"
  fi
else
  bad "nvim not found (make deps)"
fi

# --- the repo must BE the config ---
[ "$VIX" -ef "$HOME/.config/nvim" ] \
  && ok "repo is ~/.config/nvim" \
  || bad "repo is at $VIX, not ~/.config/nvim — nvim won't see it"

# --- plugins vs the lockfile ---
lazydir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy"
locked="$(grep -c '": {' "$VIX/lazy-lock.json" 2>/dev/null)"
installed="$(ls "$lazydir" 2>/dev/null | wc -l | tr -d ' ')"
if [ -n "$locked" ] && [ "$installed" -ge "$locked" ] 2>/dev/null; then
  ok "plugins installed ($installed present, $locked locked)"
else
  bad "plugins missing ($installed present, $locked locked) (make setup)"
fi

# --- clean headless startup: the whole config must load ---
if command -v nvim >/dev/null; then
  startup="$(nvim --headless "+lua print('startup-ok')" +qa 2>&1)"
  if [ $? -eq 0 ] && printf '%s' "$startup" | grep -q "startup-ok"; then
    ok "headless startup clean"
  else
    bad "headless startup had errors:"
    printf '%s\n' "$startup" | head -5 | sed 's/^/      /'
  fi
fi

# --- tools the config leans on ---
for t in rg ack fzf par pandoc; do
  command -v "$t" >/dev/null && ok "$t on PATH" || bad "$t not found (make deps)"
done

# --- providers (optional niceties — warn, never fail) ---
# python and ruby providers are disabled in global-options.lua; only node is kept
command -v node >/dev/null || warn "node not on PATH (node provider absent)"

echo
if [ "$fail" -eq 0 ]; then
  printf "${green}${bold}all good.${off}\n"
else
  printf "${red}${bold}problems found — see above.${off}\n"
fi
exit "$fail"
