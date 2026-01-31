# My dotfiles

This repository contains dotfiles and setup scripts for my Fedora systems,
specifically optimized for **Fedora Silverblue**.

## Setup Instructions

The setup process is orchestrated by `setup.sh`. Since Fedora Silverblue
requires reboots after layering packages, the script manages the state across
these reboots.

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
   Starship) and Flatpaks (VS Code, etc.). *No Reboot Required.*
4. **Dotfiles:** Stows the configuration files.

When the script asks you to reboot, say **Yes**. After rebooting, open a
terminal, navigate back to `~/dotfiles`, and run `./setup.sh` again. It will
automatically detect the previous step was finished and continue to the next
one.

## Alternative: BlueBuild Setup (Cloud Native)

Instead of running local scripts to layer packages, you can build a custom
OCI image via GitHub Actions and rebase your system to it. This effectively
"bakes" your system packages into the OS image.

### Prerequisites

1. **Fork this repository** to your own GitHub account.

2. **Push changes** to trigger the GitHub Actions workflow, which will
   automatically build your custom image and publish it to GitHub Container
   Registry.

### Usage

Once the image is built (check GitHub Actions tab), rebase your system:

1. **Pin your current deployment** (so you can easily rollback if needed):

   ```bash
   sudo ostree admin pin 0
   ```

1. **Rebase to your custom image**:

   ```bash
   rpm-ostree rebase ostree-unverified-registry:ghcr.io/your-username/silverblue-custom:latest
   ```

   *Note: Replace `your-username` with your GitHub username (lowercase).*

1. **Reboot**:

   ```bash
   systemctl reboot
   ```

After rebooting, your system will have all layered packages and Flatpaks
pre-installed. You still need to run the userspace setup and link your
dotfiles:

```bash
./scripts/03-userspace.sh
./scripts/05-dotfiles.sh
./scripts/06-gnome.sh
```

> **Note on Image Signing:** This setup does not use image signing (cosign).
> For personal use where you control the entire pipeline (repository → build →
> registry → deployment), signing provides minimal additional security value.
> If you later need to share images publicly or require compliance features,
> you can enable signing by following the [BlueBuild signing
> documentation](https://blue-build.org/how-to/cosign/).

## Installed Tools

The setup script installs and configures:

* **System/Layered:** Neovim, Stow, FZF, Fastfetch, Btop, Tailscale, Gh, Bat,
  1Password, Lazygit.
* **Userspace:** uv, Air, Pls, JetBrainsMono Nerd Font, Starship, Opencode, Quarto.
* **Flatpaks:** VS Code, LibreOffice, DevPod, Podman Desktop, Zed, Flatseal.

## Manual Dotfiles Usage

If you only want to link the configuration files without running the full installer:

```bash
./scripts/05-dotfiles.sh
```

## Updating GNOME Settings

If you make changes to your GNOME environment (e.g., keyboard shortcuts,
themes, extensions) and want to save them back to this repository, run:

```bash
dconf dump / > gnome/dconf-settings.ini
```

This will overwrite the existing `ini` file with your current system settings.
You can then commit and push these changes.
