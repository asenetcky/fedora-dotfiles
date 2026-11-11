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
git clone https://github.com/asenetcky/fedora-dotfiles.git
cd fedora-dotfiles
```

### 2. Run the Setup Script

```bash
./setup.sh
```

### 3. Follow the Prompts

The script will guide you through the phases:

1. **RPM Fusion Setup:** Installs repositories. *Reboot on atomic.*
2. **System Packages:** Installs core system packages (Neovim, Stow,
   Tailscale, etc.) via `rpm-ostree` or `dnf`. *Reboot on atomic.*
3. **Userspace:** Installs user-local tools (uv, Quarto, Fonts, Opencode)
   and enables `tailscaled`.
4. **Flatpaks:** Installs apps from Flathub (Zed, Obsidian, etc.). Apps that
   are already installed are skipped.
5. **Dotfiles:** Stows the configuration files (see below).
6. **Cleanup:** Removes unused Flatpak runtimes and `rpm-ostree` caches.

When the script asks you to reboot, answer **y**. After rebooting, open a
terminal, go back to `~/fedora-dotfiles`, and run `./setup.sh` again. It
picks up from the next step.

Once everything has run, the state is marked as complete. Running
`./setup.sh` again offers to reset the state so you can start over.

## Installed Tools

The setup script installs and configures:

* **System (core):** Neovim, Stow, GitHub CLI, FZF, Lazygit, Tailscale,
  1Password CLI (plus Toolbox on Workstation).
* **System (quality of life):** Bat, Btop, Fastfetch.
* **System (media):** VLC + RPM Fusion codecs.
* **Vendor RPMs:** 1Password, Positron.
* **Userspace:** uv, Pls, JetBrainsMono Nerd Font, Opencode, Quarto.
* **Flatpaks:** LibreOffice, Flatseal, Zed, Typesetter, Gear Lever, Obsidian.

## Manual Dotfiles Usage

If you only want to link the configuration files without running the full
installer (requires `stow`):

```bash
./scripts/05-dotfiles.sh
```

Existing files that would conflict with a link are renamed to
`<name>.bak.<timestamp>` first, so nothing is overwritten.
