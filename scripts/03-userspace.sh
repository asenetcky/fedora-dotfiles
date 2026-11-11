#!/bin/bash
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

log_info ">>> Setting up Userspace Tools..."

mkdir -p "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

# 1. uv
if ! cmd_exists uv; then
    log_info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    log_success "uv installed."
else
    log_info "uv already installed."
fi

# 2. pls (via uv)
if ! cmd_exists pls; then
    log_info "Installing pls with uv..."
    uv tool install pls
    log_success "pls installed."
else
    log_info "pls already installed."
fi

# 3. Nerd Font (release archive only, not the multi-GB repo)
FONT_NAME="JetBrainsMono"
if ! fc-list | grep -qi "${FONT_NAME} Nerd"; then
    log_info "Installing $FONT_NAME Nerd Font..."
    FONT_DIR="$HOME/.local/share/fonts/${FONT_NAME}NerdFont"
    mkdir -p "$FONT_DIR"
    curl -LsSf "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.tar.xz" |
        tar -xJ -C "$FONT_DIR"
    fc-cache -f "$FONT_DIR"
    log_success "Nerd Font installed."
else
    log_info "Nerd Font $FONT_NAME already installed."
fi

# 4. Opencode
if ! cmd_exists opencode; then
    log_info "Installing Opencode CLI..."
    curl -fsSL https://opencode.ai/install | bash
else
    log_info "Opencode already installed."
fi

# 5. Quarto
QUARTO_VERSION="1.8.26"
if [ ! -d "/opt/quarto/${QUARTO_VERSION}" ]; then
    log_info "Installing Quarto ${QUARTO_VERSION}..."
    sudo mkdir -p "/opt/quarto/${QUARTO_VERSION}"
    curl -LsSf "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz" |
        sudo tar -xz -C "/opt/quarto/${QUARTO_VERSION}" --strip-components=1
    log_success "Quarto extracted."
fi
ln -sf "/opt/quarto/${QUARTO_VERSION}/bin/quarto" "$HOME/.local/bin/quarto"
log_info "Quarto ${QUARTO_VERSION} linked to ~/.local/bin/quarto"

# 6. Tailscale daemon (package is installed in step 02 but never enabled)
if cmd_exists tailscale && ! systemctl is-enabled --quiet tailscaled; then
    log_info "Enabling tailscaled..."
    sudo systemctl enable --now tailscaled
    log_info "Run 'sudo tailscale up' to log in."
fi

log_success ">>> Step 03 Complete."
