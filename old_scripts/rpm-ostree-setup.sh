#!/bin/bash
# Dotfiles setup

## Layered Applications
echo "Installing Layered Applications"

### 1password repos
sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo'

### install all layered apps and 1password
sudo rpm-ostree install btop fastfetch fzf gh neovim stow tailscale gh bat 1password 1password-cli tailscale libavcodec-freeworld

## Development-related Appilcations

### uv

echo "Installing uv"

curl -LsSf https://astral.sh/uv/install.sh | sh

### air formatter

echo "Installing air code formatter"

curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

## cozy cli stuff

### pls for ls

echo "Installing pls(1) with uv"

uv tool install pls

### nerd fonts for terminal

echo "Installing JetBrainsMono Nerd Font"

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/utility-repos/
bash ~/utility-repos/install.sh JetBrainsMono
rm -rf ~/utility-repos
echo "JetBrainsMono Nerd Font installed successfully."

### stapship cli

echo "Installing Starship"

curl -sS https://starship.rs/install.sh | sh

### tailscale

#echo "Enabling Tailscale"
#sudo systemctl enable --now tailscaled
#sudo tailscale up --auth_key file:.tailscale

### install opencode cli agent
curl -fsSL https://opencode.ai/install | bash
