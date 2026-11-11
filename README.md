# My dotfiles

This repository contains dotfiles and setup scripts for my Fedora systems.
It works on both **Fedora Silverblue** (and other atomic desktops) and
**Fedora Workstation**.

The variant is detected automatically (`/run/ostree-booted`). To force one:

```bash
DOTFILES_VARIANT=workstation ./setup.sh   # or: atomic
```

On atomic systems packages are layered with `rpm-ostree` and the script
pauses for reboots; on Workstation it uses `dnf` and runs straight through.

## Setup Instructions

The setup process is orchestrated by `setup.sh`. Since Fedora Silverblue
requires reboots after layering packages, the script manages the state across
these reboots. If a step fails, fix the problem and re-run `./setup.sh`; it
resumes from the failed step.

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
2. **Layered Packages:** Installs core system packages (Neovim, Stow,
   Tailscale, etc.) via `rpm-ostree`. *Requires Reboot.*
3. **Userspace & Flatpaks:** Installs user-local tools (uv, Quarto, Fonts,
   Opencode) and Flatpaks (Zed, Obsidian, etc.). *No Reboot Required.*
4. **Dotfiles:** Stows the configuration files.

When the script asks you to reboot, say **Yes**. After rebooting, open a
terminal, navigate back to `~/dotfiles`, and run `./setup.sh` again. It will
automatically detect the previous step was finished and continue to the next
one.

## Installed Tools

The setup script installs and configures:

* **System (core):** Neovim, Stow, Gh, FZF, Lazygit, Tailscale, 1Password CLI.
* **System (quality of life):** Bat, Btop, Fastfetch.
* **System (media):** VLC + RPM Fusion codecs.
* **Vendor RPMs:** 1Password, Positron.
* **Userspace:** uv, Pls, JetBrainsMono Nerd Font, Opencode, Quarto.
* **Flatpaks:** LibreOffice, Flatseal, Zed, Typesetter, Gear Lever, Obsidian.

## Manual Dotfiles Usage

If you only want to link the configuration files without running the full installer:

```bash
./scripts/05-dotfiles.sh
```
