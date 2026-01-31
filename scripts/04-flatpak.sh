#!/bin/bash
set -e

echo ">>> Setting up Flatpaks..."

# Add Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpaks
FLATPAKS=(
    sh.loft.devpod
    org.libreoffice.LibreOffice
    com.github.marhkb.Pods
    com.visualstudio.code
    io.podman_desktop.PodmanDesktop
    com.github.tchx84.Flatseal
    dev.zed.Zed
)

echo "Installing Flatpaks: ${FLATPAKS[*]}"
flatpak install flathub "${FLATPAKS[@]}" -y

# VS Code Overrides
echo "Applying VS Code Overrides..."
flatpak override --user com.visualstudio.code --filesystem=~/.1password:ro
flatpak override --user com.visualstudio.code --filesystem=~/.bashrc:ro
flatpak override --user com.visualstudio.code --filesystem=~/.ssh
flatpak override --user com.visualstudio.code --filesystem=~/.gitconfig --filesystem=xdg-config/git
# Tailscale access for VS Code
flatpak override --user --filesystem=/usr/bin/tailscaled com.visualstudio.code
flatpak override --user --filesystem=/var/run/tailscale/tailscaled.sock com.visualstudio.code

echo ">>> Step 04 Complete."
