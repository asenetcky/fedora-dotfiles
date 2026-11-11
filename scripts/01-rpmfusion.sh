#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up RPM Fusion Repos..."

if rpm -q rpmfusion-free-release rpmfusion-nonfree-release &>/dev/null; then
    log_info "RPM Fusion already installed. Skipping."
else
    log_info "Installing RPM Fusion repo packages..."
    sys_install \
        "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
        "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi

# On atomic systems the release packages were installed from versioned URLs and
# must be swapped for the repo-tracked versions so they follow major upgrades.
# That can only happen once the repos are active (i.e. after a reboot), so it is
# done at the start of 02-layered-pkgs.sh.

if is_atomic; then
    log_success ">>> Step 01 Complete. A reboot is required to activate these repos."
else
    log_success ">>> Step 01 Complete."
fi
