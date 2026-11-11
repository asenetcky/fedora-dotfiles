#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up Flatpaks..."

# Add Flathub (Workstation may ship it disabled)
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

FLATPAKS=(
  org.libreoffice.LibreOffice
  com.github.tchx84.Flatseal
  dev.zed.Zed
  net.trowell.typesetter
  it.mijorus.gearlever
  md.obsidian.Obsidian
)

TO_INSTALL=()
for app in "${FLATPAKS[@]}"; do
  # Skip anything already installed (from any remote, user or system)
  if flatpak info "$app" &>/dev/null; then
    log_info "Already installed, skipping: $app"
  else
    TO_INSTALL+=("$app")
  fi
done

if [ ${#TO_INSTALL[@]} -eq 0 ]; then
  log_info "All Flatpaks already installed."
else
  log_info "Installing Flatpaks: ${TO_INSTALL[*]}"
  flatpak install flathub "${TO_INSTALL[@]}" -y --noninteractive
fi

log_success ">>> Step 04 Complete."
