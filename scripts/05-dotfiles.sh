#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Stowing Dotfiles..."

# Backup function
backup_file() {
    if [ -f "$1" ] && [ ! -L "$1" ]; then
        log_info "Backing up $1 to $1.bak"
        mv "$1" "$1.bak"
    fi
}

backup_file "$HOME/.gitconfig"
backup_file "$HOME/.bashrc"

# Ensure we are in the dotfiles directory
CDIR="$(dirname "$0")"
DOTFILES_ROOT="$(realpath "$CDIR/../")"

log_info "Stowing from $DOTFILES_ROOT"
pushd "$DOTFILES_ROOT" > /dev/null
# stow . handles the symlinking
if stow .; then
    log_success "Dotfiles stowed successfully."
else
    log_error "Stow failed."
    popd > /dev/null
    exit 1
fi
popd > /dev/null

log_success ">>> Step 05 Complete."
