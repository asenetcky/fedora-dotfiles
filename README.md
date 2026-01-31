# My dotfiles

This repository contains dotfiles and setup scripts for my Fedora systems, specifically optimized for **Fedora Silverblue**.

## Setup Instructions

The setup process is orchestrated by `setup.sh`. Since Fedora Silverblue requires reboots after layering packages, the script manages the state across these reboots.

### 1. Clone the repository

```bash
cd ~
git clone https://github.com/asenetcky/dotfiles.git
cd dotfiles
```

### 2. Run the Setup Script

```bash
./setup.sh
```

### 3. Follow the Prompts

The script will guide you through the phases:

1. **RPM Fusion Setup:** Installs repositories. *Requires Reboot.*
2. **Layered Packages:** Installs core system packages (Neovim, Stow, Tailscale, etc.) via `rpm-ostree`. *Requires Reboot.*
3. **Userspace & Flatpaks:** Installs user-local tools (uv, Quarto, Fonts, Starship) and Flatpaks (VS Code, etc.). *No Reboot Required.*
4. **Dotfiles:** Stows the configuration files.

When the script asks you to reboot, say **Yes**. After rebooting, open a terminal, navigate back to `~/dotfiles`, and run `./setup.sh` again. It will automatically detect the previous step was finished and continue to the next one.

## Installed Tools

The setup script installs and configures:

* **System/Layered:** Neovim, Stow, FZF, Fastfetch, Btop, Tailscale, Gh, Bat, 1Password, Lazygit.
* **Userspace:** uv, Air, Pls, JetBrainsMono Nerd Font, Starship, Opencode, Quarto.
* **Flatpaks:** VS Code, LibreOffice, DevPod, Podman Desktop, Zed, Flatseal.

## Manual Dotfiles Usage

If you only want to link the configuration files without running the full installer:

```bash
./scripts/05-dotfiles.sh
```
