#!/bin/bash
set -e

echo ">>> Setting up RPM Fusion Repos..."

# Check if already installed to avoid redundant operations
if rpm -q rpmfusion-free-release &>/dev/null && rpm -q rpmfusion-nonfree-release &>/dev/null; then
    echo "RPM Fusion already installed. Skipping..."
else
    sudo rpm-ostree install 
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi

# We don't necessarily need the update step immediately if we are going to layer packages next, 
# but the original script had it. Let's keep it but make it conditional or separate?
# The original script did: install repos -> update (uninstall/install dance) -> reboot.
# The uninstall/install dance is sometimes needed to fix version locks.

echo ">>> Ensuring RPM Fusion repos are fully consistent..."
# This command is often used to ensure the repo packages themselves are the correct version matching the tree
sudo rpm-ostree update 
    --uninstall rpmfusion-free-release 
    --uninstall rpmfusion-nonfree-release 
    --install rpmfusion-free-release 
    --install rpmfusion-nonfree-release

echo ">>> Step 01 Complete. A reboot is usually required to activate these repos before layering packages."
