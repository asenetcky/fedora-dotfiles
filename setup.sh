#! /bin/bash

sudo dnf upgrade
sudo dnf install -y neovim fzf stow fastfetch R-devel btop bat tailscale

sudo dnf install -y dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh --repo gh-cli

sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
sudo dnf install -y 1password 1password-cli

sudo dnf copr enable -y dejan/lazygit
sudo dnf install -y lazygit

QUARTO_VERSION="1.8.26"

sudo mkdir -p /opt/quarto/${QUARTO_VERSION}

sudo curl -o quarto.tar.gz -L \
  "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"

sudo tar -zxvf quarto.tar.gz \
  -C "/opt/quarto/${QUARTO_VERSION}" \
  --strip-components=1

sudo rm quarto.tar.gz

/opt/quarto/"${QUARTO_VERSION}"/bin/quarto check

sudo ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto

curl -LsSf https://astral.sh/uv/install.sh | sh

curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh

uv tool install pls

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git ~/utility-repos/
bash ~/utility-repos/install.sh JetBrainsMono
rm -rf ~/utility-repos
echo "Nerd Fonts installed successfully."

curl -sS https://starship.rs/install.sh | sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
