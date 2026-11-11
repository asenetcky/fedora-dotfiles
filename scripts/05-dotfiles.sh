#!/bin/bash
set -e

source "$(dirname "$0")/common.sh"

log_info ">>> Stowing Dotfiles..."

DOTFILES_ROOT="$(realpath "$(dirname "$0")/..")"

# -d/-t: stow's default target is the *parent* of the repo, not $HOME
# --no-folding: link individual files, so e.g. ~/.ssh stays a real directory
#               and keys/known_hosts never end up inside the repo
STOW=(stow --no-folding -d "$DOTFILES_ROOT" -t "$HOME")

# List paths (relative to $HOME) that stow refuses to overwrite
find_conflicts() {
    "${STOW[@]}" -n . 2>&1 |
        sed -nE \
            -e 's/.*existing target [^:]*: (.*)$/\1/p' \
            -e 's/.* over existing target (.*) since .*/\1/p' |
        sort -u
}

# A symlinked directory not owned by stow (e.g. ~/.ssh -> ~/old-dotfiles/.ssh)
# is reported as a conflict as a whole. Backing it up would hide everything
# inside it, so replace the link with a real directory holding a copy of its
# contents (the original stays where the link pointed); any individual files
# that still conflict are then backed up below.
mapfile -t CONFLICTS < <(find_conflicts)
for target in "${CONFLICTS[@]}"; do
    [ -n "$target" ] || continue
    if [ -L "$HOME/$target" ] && [ -d "$HOME/$target" ] && [ -d "$DOTFILES_ROOT/$target" ]; then
        src="$(realpath "$HOME/$target")"
        log_warn "Replacing symlink ~/$target -> $src with a real directory (contents copied)"
        rm "$HOME/$target"
        mkdir "$HOME/$target"
        cp -a "$src/." "$HOME/$target/"
    fi
done

# Move anything that still conflicts out of the way (stow refuses to overwrite)
mapfile -t CONFLICTS < <(find_conflicts)
STAMP="$(date +%Y%m%d%H%M%S)"
for target in "${CONFLICTS[@]}"; do
    [ -n "$target" ] || continue
    log_warn "Backing up ~/$target -> ~/$target.bak.$STAMP"
    mv "$HOME/$target" "$HOME/$target.bak.$STAMP"
done

log_info "Stowing from $DOTFILES_ROOT into $HOME"
if "${STOW[@]}" --restow .; then
    log_success "Dotfiles stowed successfully."
else
    log_error "Stow failed."
    exit 1
fi

log_success ">>> Step 05 Complete."
