#!/bin/bash
set -e

echo ">>> Setting up Layered Applications..."

# 1Password Repo
if [ ! -f /etc/yum.repos.d/1password.repo ]; then
    echo "Adding 1Password repo..."
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo'
fi

# Lazygit Repo (COPR)
if [ ! -f /etc/yum.repos.d/lazygit.repo ]; then
    echo "Adding Lazygit repo..."
    # Using generic version logic or hardcoded from original? Original was fedora-43 hardcoded (!)
    # Better to use $(rpm -E %fedora) if possible, but the URL structure depends on the copr.
    # The original URL: https://copr.fedorainfracloud.org/coprs/dejan/lazygit/repo/fedora-43/dejan-lazygit-fedora-43.repo
    # Let's try to make it dynamic or fallback to user's version.
    FEDORA_VERSION=$(rpm -E %fedora)
    sudo curl "https://copr.fedorainfracloud.org/coprs/dejan/lazygit/repo/fedora-${FEDORA_VERSION}/dejan-lazygit-fedora-${FEDORA_VERSION}.repo" -o /etc/yum.repos.d/lazygit.repo
fi

# Install Packages
# Consolidated list
PKGS=(
    btop
    fastfetch
    fzf
    gh
    neovim
    stow
    tailscale
    bat
    1password
    1password-cli
    libavcodec-freeworld
    lazygit
)

echo "Installing/Layering packages: ${PKGS[*]}"
sudo rpm-ostree install "${PKGS[@]}"

echo ">>> Step 02 Complete. Reboot required to boot into new deployment."
