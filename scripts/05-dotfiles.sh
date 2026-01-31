#!/bin/bash
set -e

echo ">>> Stowing Dotfiles..."

# Backup function
backup_file() {
    if [ -f "$1" ] && [ ! -L "$1" ]; then
        echo "Backing up $1 to $1.bak"
        mv "$1" "$1.bak"
    fi
}

backup_file ~/.gitconfig
backup_file ~/.bashrc

# Ensure we are in the dotfiles directory
CDIR="$(dirname "$0")"
DOTFILES_ROOT="$(realpath "$CDIR/../")"

echo "Stowing from $DOTFILES_ROOT"
pushd "$DOTFILES_ROOT" > /dev/null
stow .
popd > /dev/null

echo ">>> Step 05 Complete."
