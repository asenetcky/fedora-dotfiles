#!/bin/bash
set -e

# Source common functions
source "$(dirname "$0")/common.sh"

log_info ">>> Setting up Userspace Tools..."

# 1. uv
if ! cmd_exists uv; then
    log_info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    log_success "uv installed."
else
    log_info "uv already installed."
fi

# 2. air (Go hot reload)
log_info "Installing air..."
# Air doesn't have a standardized "check" easily without path, so we reinstall/update safely.
curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

# 3. pls (via uv)
log_info "Installing pls with uv..."
export PATH="$HOME/.local/bin:$PATH"
if ! cmd_exists pls; then
    uv tool install pls
    log_success "pls installed."
else
    log_info "pls already installed."
fi

# 4. Nerd Fonts
FONT_NAME="JetBrainsMono"
if ! fc-list | grep -q "$FONT_NAME"; then
    log_info "Installing $FONT_NAME Nerd Font..."
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git "$TEMP_DIR/nerd-fonts"
    bash "$TEMP_DIR/nerd-fonts/install.sh" "$FONT_NAME"
    rm -rf "$TEMP_DIR"
    log_success "Nerd Fonts installed."
else
    log_info "Nerd Font $FONT_NAME seems to be installed."
fi

# 5. Starship
if ! cmd_exists starship; then
    log_info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    log_success "Starship installed."
else
    log_info "Starship already installed."
fi

# 6. Opencode
log_info "Installing Opencode CLI..."
curl -fsSL https://opencode.ai/install | bash

# 7. Quarto
QUARTO_VERSION="1.8.26"
if [ ! -d "/opt/quarto/${QUARTO_VERSION}" ]; then
    log_info "Installing Quarto ${QUARTO_VERSION}..."
    sudo mkdir -p "/opt/quarto/${QUARTO_VERSION}"
    
    TEMP_DIR=$(mktemp -d)
    pushd "$TEMP_DIR" > /dev/null
    
    if curl -o quarto.tar.gz -L "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"; then
        sudo tar -zxvf quarto.tar.gz -C "/opt/quarto/${QUARTO_VERSION}" --strip-components=1
        log_success "Quarto extracted."
    else
        log_error "Failed to download Quarto."
        exit 1
    fi
    popd > /dev/null
    rm -rf "$TEMP_DIR"
    
    # Link
    log_info "Linking Quarto..."
    if sudo ln -sf "/opt/quarto/${QUARTO_VERSION}/bin/quarto" /usr/local/bin/quarto; then
        log_success "Linked to /usr/local/bin/quarto"
    else
        log_warn "Could not link to /usr/local/bin. Trying ~/.local/bin..."
        mkdir -p "$HOME/.local/bin"
        ln -sf "/opt/quarto/${QUARTO_VERSION}/bin/quarto" "$HOME/.local/bin/quarto"
        log_success "Linked to $HOME/.local/bin/quarto"
    fi
else
    log_info "Quarto ${QUARTO_VERSION} already installed."
fi

# 8. Lazydocker
if ! cmd_exists lazydocker; then
    log_info "Installing Lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
else
     log_info "Lazydocker already installed."
fi

# 9. Toolbox
log_info "Creating default toolbox container..."
if ! toolbox list | grep -q "default"; then
    if toolbox create -c default -y; then
        log_success "Toolbox 'default' created."
    else
        log_warn "Toolbox creation returned an error (it might already exist)."
    fi
else
    log_info "Toolbox 'default' already exists."
fi

log_success ">>> Step 03 Complete."
