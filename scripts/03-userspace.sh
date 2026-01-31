#!/bin/bash
set -e

echo ">>> Setting up Userspace Tools..."

# 1. uv
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv already installed."
fi

# 2. air (Go hot reload)
# The original script installs to system? "curl ... | sh". Usually installs to bin folder.
# Default install location for air script is often ./bin or $(go env GOPATH)/bin.
# Let's check the script URL content if we were unsure, but standard is often local bin.
# We will trust the original command.
echo "Installing air..."
curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

# 3. pls (via uv)
echo "Installing pls with uv..."
# Ensure uv is in path for this session if just installed
export PATH="$HOME/.local/bin:$PATH"
uv tool install pls

# 4. Nerd Fonts
FONT_NAME="JetBrainsMono"
if ! fc-list | grep -q "$FONT_NAME"; then
    echo "Installing $FONT_NAME Nerd Font..."
    mkdir -p ~/utility-repos
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/utility-repos/nerd-fonts
    bash ~/utility-repos/nerd-fonts/install.sh "$FONT_NAME"
    rm -rf ~/utility-repos
    echo "Nerd Fonts installed."
else
    echo "Nerd Font $FONT_NAME seems to be installed."
fi

# 5. Starship
if ! command -v starship &> /dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "Starship already installed."
fi

# 6. Opencode
echo "Installing Opencode CLI..."
curl -fsSL https://opencode.ai/install | bash

# 7. Quarto
# From dnf-setup.sh
QUARTO_VERSION="1.8.26"
if [ ! -d "/opt/quarto/${QUARTO_VERSION}" ]; then
    echo "Installing Quarto ${QUARTO_VERSION}..."
    sudo mkdir -p "/opt/quarto/${QUARTO_VERSION}"
    
    # Download to tmp
    pushd /tmp
    curl -o quarto.tar.gz -L "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"
    
    sudo tar -zxvf quarto.tar.gz -C "/opt/quarto/${QUARTO_VERSION}" --strip-components=1
    rm quarto.tar.gz
    popd
    
    # Link
    # Check if link exists
    if [ ! -L "/usr/local/bin/quarto" ]; then
        # /usr/local/bin might be read-only on Silverblue?
        # /usr/local is usually a symlink to /var/usrlocal on Silverblue.
        # Let's attempt it.
        echo "Linking Quarto..."
        sudo ln -sf "/opt/quarto/${QUARTO_VERSION}/bin/quarto" /usr/local/bin/quarto || echo "Warning: Could not link quarto to /usr/local/bin. Add /opt/quarto/${QUARTO_VERSION}/bin to PATH manually."
    fi
else
    echo "Quarto ${QUARTO_VERSION} already installed."
fi

# 8. Lazydocker
if ! command -v lazydocker &> /dev/null; then
    echo "Installing Lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi

echo ">>> Step 03 Complete."
