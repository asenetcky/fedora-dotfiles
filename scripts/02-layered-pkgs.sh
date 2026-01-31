#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up Layered Applications..."

# 1Password Repo
if [ ! -f /etc/yum.repos.d/1password.repo ]; then
    log_info "Adding 1Password repo..."
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'cat <<EOF > /etc/yum.repos.d/1password.repo
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc
EOF'
fi

# Lazygit Repo (COPR)
if [ ! -f /etc/yum.repos.d/lazygit.repo ]; then
    log_info "Adding Lazygit repo..."
    FEDORA_VERSION=$(rpm -E %fedora)
    sudo curl -LsSf "https://copr.fedorainfracloud.org/coprs/dejan/lazygit/repo/fedora-${FEDORA_VERSION}/dejan-lazygit-fedora-${FEDORA_VERSION}.repo" -o /etc/yum.repos.d/lazygit.repo
fi

# Install Packages
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

log_info "Installing/Layering packages: ${PKGS[*]}"
sudo rpm-ostree install --idempotent "${PKGS[@]}"

log_success ">>> Step 02 Complete. Reboot required to boot into new deployment."
