# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0](https://github.com/asenetcky/fedora-dotfiles/compare/v0.2.6...v0.3.0) (2026-11-11)


### Features

* add dependabot configuration for automated updates ([07258a4](https://github.com/asenetcky/fedora-dotfiles/commit/07258a499a096f3520c1917b55f0d71f1b113396))
* add flatpak mozilla and layered vlc and codecs ([758d847](https://github.com/asenetcky/fedora-dotfiles/commit/758d8473de239276bfa328c919f1b483a52fa0a9))
* add Gear Lever and Obsidian Flatpaks ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* add github actions for linting, validation, and automated releases ([0cdf1ab](https://github.com/asenetcky/fedora-dotfiles/commit/0cdf1ab35621d2b1d14982e5a174dbda01584df9))
* add typsetter for typst ([68a91df](https://github.com/asenetcky/fedora-dotfiles/commit/68a91df6b0ca65bc29f288e76e4689693ef5a56a))
* install Positron and 1Password from vendor RPMs ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* rework package selection into core, quality-of-life and media groups ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* support Fedora Workstation alongside Silverblue ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))


### Bug Fixes

* download only the JetBrainsMono Nerd Font archive instead of cloning the nerd-fonts repo ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* enable tailscaled after installing tailscale ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* guard fzf and fastfetch in .bashrc so shells without them don't error ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* repair setup orchestration and stow linking ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* run the RPM Fusion package swap after the reboot, not before ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))
* stop reinstalling opencode on every run ([2df72cf](https://github.com/asenetcky/fedora-dotfiles/commit/2df72cf0794dcf2b7f637f18511520956c769828))

## [0.2.6] - 2026-01-30

### Added

- Documentation in `README.md` and `scripts/06-gnome.sh` for updating GNOME
  settings using `dconf dump`.

### Changed

- Updated GNOME settings in `gnome/dconf-settings.ini` to include custom
  keybindings (Ptyxis, 1Password), teal accent color, and improved
  notification/touchpad settings.

## [0.2.5] - 2026-01-30

### Added

- Created `AGENTS.md` to provide high-level context for LLM agents working
  on the project.

### Fixed

- Improved `scripts/02-layered-pkgs.sh` by adding the `--idempotent` flag to
  `rpm-ostree install`, preventing script failure if packages are already
  layered.

## [0.2.4] - 2026-01-30

### Changed

- Stopped tracking `.ssh/known_hosts` in Git and added it to `.gitignore`
  to reduce noise and improve security.

## [0.2.3] - 2026-01-30

### Changed

- Updated `tests/validate_install.sh` to include checks for `opencode` and
  GNOME settings backup.

## [0.2.2] - 2026-01-30

### Fixed

- Improved `setup.sh` robustness by making it location-aware (can be run from
  any directory).

## [0.2.1] - 2026-01-30

### Fixed

- Fixed syntax errors in `scripts/01-rpmfusion.sh` caused by missing line
  continuation backslashes.
- Standardized logging using `common.sh` across all setup scripts.
- Fixed 1Password repository installation block in `scripts/02-layered-pkgs.sh`.

## [0.2.0] - 2026-01-30

### Added

- New `scripts/common.sh` library for shared logging and utility functions.
- New `tests/validate_install.sh` script for verifying the system state after installation.
- New `scripts/06-gnome.sh` for automated GNOME settings restoration via `dconf`.
- New `scripts/99-cleanup.sh` for system pruning (`rpm-ostree` and Flatpak).
- Automated toolbox creation (named 'default') in `scripts/03-userspace.sh`.

### Changed

- **Hardening:** Switched to `mktemp` for all temporary downloads in `scripts/03-userspace.sh`.
- **Robustness:** Added `--or-update` to Flatpak installations to ensure idempotency.
- **Portability:** Replaced hardcoded home paths in `.bashrc` with `$HOME`.

### Fixed

- Improved Quarto installation logic with a fallback to `~/.local/bin` if
  `/usr/local/bin` is immutable.

## [0.1.0] - 2026-01-30

### Added

- New master orchestration script `setup.sh` that supports state-tracking
  and resumes after system reboots.
- Modularized setup scripts in `scripts/` directory:
  - `01-rpmfusion.sh`: Automated RPM Fusion repository configuration.
  - `02-layered-pkgs.sh`: Consolidated `rpm-ostree` package layering.
  - `03-userspace.sh`: Toolchain installation (uv, air, starship, quarto, etc.).
  - `04-flatpak.sh`: Flatpak application management and VS Code permission overrides.
  - `05-dotfiles.sh`: Safe dotfiles stowing with backup logic.
- Comprehensive documentation in `README.md` for the new Silverblue workflow.

### Changed

- Reorganized project structure to separate logic from configuration.
- Consolidated disparate setup scripts into a unified workflow.

### Fixed

- Fixed hardcoded Fedora versions in repository URLs to use dynamic version
  detection (`rpm -E %fedora`).
- Improved dotfiles linking safety by adding backups for existing `.bashrc`
  and `.gitconfig`.

### Removed

- Moved legacy setup scripts to `old_scripts/` to declutter the repository root.

[0.1.0]: https://github.com/asenetcky/dotfiles/releases/tag/v0.1.0
