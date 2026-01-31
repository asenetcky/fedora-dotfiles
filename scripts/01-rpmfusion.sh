#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up RPM Fusion Repos..."

# Check if already installed to avoid redundant operations
if rpm -q rpmfusion-free-release &>/dev/null && rpm -q rpmfusion-nonfree-release &>/dev/null; then
    log_info "RPM Fusion already installed. Skipping initial install..."
else
    log_info "Installing RPM Fusion repo packages..."
    sudo rpm-ostree install \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi

log_info ">>> Ensuring RPM Fusion repos are fully consistent..."
# This command ensures the repo packages themselves are the correct version matching the tree
sudo rpm-ostree update \
    --uninstall rpmfusion-free-release \
    --uninstall rpmfusion-nonfree-release \
    --install rpmfusion-free-release \
    --install rpmfusion-nonfree-release

log_success ">>> Step 01 Complete. A reboot is usually required to activate these repos."
