#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Cleaning up System..."

log_info "Pruning unused Flatpak runtimes..."
flatpak uninstall --unused -y

if is_atomic; then
    log_info "Cleaning up rpm-ostree metadata and cache..."
    sudo rpm-ostree cleanup -m
    sudo rpm-ostree cleanup -b
else
    log_info "Cleaning dnf package cache..."
    sudo dnf clean packages
fi

log_success ">>> Step 99 (Cleanup) Complete."
