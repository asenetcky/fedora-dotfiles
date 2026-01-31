#!/bin/bash
set -e

# Source common functions
# We need to find common.sh relative to this script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/../scripts/common.sh"

log_info ">>> Validating Installation..."

FAILED=0

check_cmd() {
    if cmd_exists "$1"; then
        log_success "Found command: $1"
    else
        log_error "Missing command: $1"
        FAILED=1
    fi
}

check_flatpak() {
    if flatpak list --app --columns=application | grep -q "$1"; then
        log_success "Found Flatpak: $1"
    else
        log_error "Missing Flatpak: $1"
        FAILED=1
    fi
}

# 1. Check Layered/System Packages
log_info "Checking System Packages..."
check_cmd nvim
check_cmd fzf
check_cmd stow
check_cmd tailscale
check_cmd gh
check_cmd bat
check_cmd 1password
check_cmd lazygit

# 2. Check Userspace Tools
log_info "Checking Userspace Tools..."
check_cmd uv
check_cmd starship
check_cmd quarto
check_cmd lazydocker
# pls is a uv tool, check if it's in path
check_cmd pls

# 3. Check Flatpaks
log_info "Checking Flatpaks..."
check_flatpak com.visualstudio.code
check_flatpak dev.zed.Zed
check_flatpak org.libreoffice.LibreOffice

# 4. Check Toolbox
log_info "Checking Toolbox..."
if toolbox list | grep -q "default"; then
    log_success "Found toolbox 'default'"
else
    log_error "Missing toolbox 'default'"
    FAILED=1
fi

if [ $FAILED -eq 0 ]; then
    log_success ">>> All checks passed!"
    exit 0
else
    log_error ">>> Some checks failed."
    exit 1
fi
