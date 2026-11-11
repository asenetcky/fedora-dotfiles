#!/bin/bash

# Common utility functions for dotfiles setup

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
cmd_exists() {
    command -v "$1" &> /dev/null
}

# --- OS variant detection -----------------------------------------------------
# "atomic"      -> Silverblue / Kinoite / other rpm-ostree systems
# "workstation" -> traditional dnf-based Fedora
# Override with: DOTFILES_VARIANT=atomic|workstation ./setup.sh
detect_variant() {
    case "${DOTFILES_VARIANT:-}" in
    atomic | workstation)
        echo "$DOTFILES_VARIANT"
        return
        ;;
    "") ;;
    *)
        log_error "Invalid DOTFILES_VARIANT='$DOTFILES_VARIANT' (expected atomic or workstation)" >&2
        exit 1
        ;;
    esac

    if [ -e /run/ostree-booted ]; then
        echo "atomic"
    else
        echo "workstation"
    fi
}

VARIANT="$(detect_variant)" || exit 1
export DOTFILES_VARIANT="$VARIANT"

is_atomic() {
    [ "$VARIANT" = "atomic" ]
}

# Install system packages with the right tool for this variant.
# On atomic systems the result only takes effect after a reboot.
sys_install() {
    if is_atomic; then
        # --idempotent: don't fail if already requested
        # --allow-inactive: don't fail if already in the base image
        sudo rpm-ostree install --idempotent --allow-inactive "$@"
    else
        sudo dnf install -y "$@"
    fi
}
