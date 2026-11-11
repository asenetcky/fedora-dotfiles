#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Setting up System Packages ($VARIANT)..."

# Atomic only: swap the URL-installed RPM Fusion release packages for the
# repo-tracked ones (requires the repos to be active, i.e. after the step 01 reboot).
# deployments[0] is the newest (pending if one is staged), so re-runs are safe.
if is_atomic && rpm-ostree status --json |
  jq -e '.deployments[0]["requested-local-packages"] // [] | any(startswith("rpmfusion-"))' >/dev/null; then
  log_info "Switching RPM Fusion release packages to repo-tracked versions..."
  sudo rpm-ostree update \
    --uninstall rpmfusion-free-release \
    --uninstall rpmfusion-nonfree-release \
    --install rpmfusion-free-release \
    --install rpmfusion-nonfree-release
fi

# 1Password Repo, for 1password-cli (the key is imported from gpgkey= on first use)
if [ ! -f /etc/yum.repos.d/1password.repo ]; then
  log_info "Adding 1Password repo..."
  sudo tee /etc/yum.repos.d/1password.repo >/dev/null <<'EOF'
[1password]
name=1Password Stable Channel
baseurl=https://downloads.1password.com/linux/rpm/stable/$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.1password.com/linux/keys/1password.asc
EOF
fi

# Lazygit Repo (COPR)
if [ ! -f /etc/yum.repos.d/lazygit.repo ]; then
  log_info "Adding Lazygit repo..."
  FEDORA_VERSION=$(rpm -E %fedora)
  sudo curl -LsSf "https://copr.fedorainfracloud.org/coprs/dejan/lazygit/repo/fedora-${FEDORA_VERSION}/dejan-lazygit-fedora-${FEDORA_VERSION}.repo" -o /etc/yum.repos.d/lazygit.repo
fi

# --- Packages from repos ------------------------------------------------------

# Core: things the dotfiles/workflow depend on
CORE_PKGS=(
  neovim
  stow
  gh
  fzf
  lazygit
  tailscale
  1password-cli
)

# Quality of life: nice to have, nothing else depends on them
QOL_PKGS=(
  bat
  btop
  fastfetch
)

# Media: codecs + VLC (layered; the Flatpak has issues)
MEDIA_PKGS=(
  libavcodec-freeworld
  vlc
  vlc-cli
  vlc-plugins-freeworld
  vlc-plugin-pipewire
  vlc-plugin-gstreamer
  vlc-plugin-ffmpeg
)

PKGS=("${CORE_PKGS[@]}" "${QOL_PKGS[@]}" "${MEDIA_PKGS[@]}")

# Workstation doesn't ship toolbox by default
if ! is_atomic; then
  PKGS+=(toolbox)
fi

# --- Packages from vendor RPM URLs --------------------------------------------
# Note: these don't update with `rpm-ostree upgrade` / `dnf upgrade`; re-run
# after removing the package (or install the new RPM) to update.

# 1Password desktop app
if ! rpm -q 1password &>/dev/null; then
  PKGS+=("https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm")
fi

# Positron (no "latest" URL, so scrape the download page; fall back to a pinned version)
if ! rpm -q positron &>/dev/null; then
  POSITRON_FALLBACK="https://cdn.posit.co/positron/releases/rpm/x86_64/Positron-2026.11.1-4-x64.rpm"
  POSITRON_URL="$(curl -fsSL https://positron.posit.co/download 2>/dev/null |
    grep -oE 'https://cdn\.posit\.co/positron/releases/rpm/x86_64/Positron-[0-9.]+-[0-9]+-x64\.rpm' |
    sort -uV | tail -1 || true)"
  PKGS+=("${POSITRON_URL:-$POSITRON_FALLBACK}")
fi

log_info "Installing packages: ${PKGS[*]}"
sys_install "${PKGS[@]}"

if is_atomic; then
  log_success ">>> Step 02 Complete. Reboot required to boot into new deployment."
else
  log_success ">>> Step 02 Complete."
fi
