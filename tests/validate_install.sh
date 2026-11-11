#!/bin/bash
set -e

# Source common functions
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../scripts/common.sh"

log_info ">>> Validating Installation ($VARIANT)..."

# User-local tools aren't on PATH in a non-interactive shell
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

FAILED=0

check_cmd() {
  if cmd_exists "$1"; then
    log_success "Found command: $1"
  else
    log_error "Missing command: $1"
    FAILED=1
  fi
}

check_flatpak() {
  if flatpak list --app --columns=application | grep -q "$1"; then
    log_success "Found Flatpak: $1"
  else
    log_error "Missing Flatpak: $1"
    FAILED=1
  fi
}

# 1. Check System Packages
log_info "Checking System Packages..."
for c in nvim stow gh fzf lazygit tailscale op bat btop fastfetch vlc 1password positron; do
  check_cmd "$c"
done

# 2. Check Userspace Tools
log_info "Checking Userspace Tools..."
for c in uv pls opencode quarto; do
  check_cmd "$c"
done

# 3. Check Flatpaks
log_info "Checking Flatpaks..."
for app in org.libreoffice.LibreOffice com.github.tchx84.Flatseal dev.zed.Zed \
  net.trowell.typesetter it.mijorus.gearlever md.obsidian.Obsidian; do
  check_flatpak "$app"
done

if [ $FAILED -eq 0 ]; then
  log_success ">>> All checks passed!"
  exit 0
else
  log_error ">>> Some checks failed."
  exit 1
fi
