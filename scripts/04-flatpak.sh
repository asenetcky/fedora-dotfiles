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

log_info "Installing Flatpaks: ${FLATPAKS[*]}"
# --or-update ensures we don't fail if already installed, and updates if available
flatpak install flathub "${FLATPAKS[@]}" -y --or-update

log_success ">>> Step 04 Complete."
