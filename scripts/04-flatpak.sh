#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up Flatpaks..."

# Add Flathub
if ! flatpak remote-list | grep -q "flathub"; then
  log_info "Adding Flathub remote..."
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
  log_info "Flathub remote already exists."
fi

# Install Flatpaks
FLATPAKS=(
  sh.loft.devpod
  org.libreoffice.LibreOffice
  com.github.marhkb.Pods
  com.visualstudio.code
  io.podman_desktop.PodmanDesktop
  com.github.tchx84.Flatseal
  dev.zed.Zed
  org.mozilla.firfox
  net.trowell.typesetter
)

log_info "Installing Flatpaks: ${FLATPAKS[*]}"
# --or-update ensures we don't fail if already installed, and updates if available
flatpak install flathub "${FLATPAKS[@]}" -y --or-update

# VS Code Overrides
log_info "Applying VS Code Overrides..."
flatpak override --user com.visualstudio.code --filesystem=~/.1password:ro
flatpak override --user com.visualstudio.code --filesystem=~/.bashrc:ro
flatpak override --user com.visualstudio.code --filesystem=~/.ssh
flatpak override --user com.visualstudio.code --filesystem=~/.gitconfig --filesystem=xdg-config/git

# Tailscale access for VS Code
flatpak override --user --filesystem=/usr/bin/tailscaled com.visualstudio.code
flatpak override --user --filesystem=/var/run/tailscale/tailscaled.sock com.visualstudio.code

log_success ">>> Step 04 Complete."
