# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.4] - 2026-01-30

### Changed
- Stopped tracking `.ssh/known_hosts` in Git and added it to `.gitignore` to reduce noise and improve security.

## [0.2.3] - 2026-01-30

### Changed
- Updated `tests/validate_install.sh` to include checks for `opencode` and GNOME settings backup.

## [0.2.2] - 2026-01-30

### Fixed
- Improved `setup.sh` robustness by making it location-aware (can be run from any directory).

## [0.2.1] - 2026-01-30

### Fixed
- Fixed syntax errors in `scripts/01-rpmfusion.sh` caused by missing line continuation backslashes.
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
- Improved Quarto installation logic with a fallback to `~/.local/bin` if `/usr/local/bin` is immutable.

## [0.1.0] - 2026-01-30

### Added
- New master orchestration script `setup.sh` that supports state-tracking and resumes after system reboots.
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
- Fixed hardcoded Fedora versions in repository URLs to use dynamic version detection (`rpm -E %fedora`).
- Improved dotfiles linking safety by adding backups for existing `.bashrc` and `.gitconfig`.

### Removed
- Moved legacy setup scripts to `old_scripts/` to declutter the repository root.

[0.1.0]: https://github.com/asenetcky/dotfiles/releases/tag/v0.1.0
