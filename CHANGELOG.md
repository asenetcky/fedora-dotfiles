# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0](https://github.com/asenetcky/fedora-dotfiles/compare/v0.2.6...v0.3.0) (2026-02-05)


### Features

* add alias for xdg-open because I am lazy ([f0a6d50](https://github.com/asenetcky/fedora-dotfiles/commit/f0a6d5002ddf99572cfaa8d0daf3fa32b891bae7))
* add dependabot configuration for automated updates ([07258a4](https://github.com/asenetcky/fedora-dotfiles/commit/07258a499a096f3520c1917b55f0d71f1b113396))
* add flatpak ([b292beb](https://github.com/asenetcky/fedora-dotfiles/commit/b292beb87d3b656ff44d1b9e4682a93e8034f6dd))
* add flatpak installation ([799a541](https://github.com/asenetcky/fedora-dotfiles/commit/799a541fed18b997f1608fcde26ed83afa72e39a))
* add flatpak mozilla and layered vlc and codecs ([758d847](https://github.com/asenetcky/fedora-dotfiles/commit/758d8473de239276bfa328c919f1b483a52fa0a9))
* add github actions for linting, validation, and automated releases ([0cdf1ab](https://github.com/asenetcky/fedora-dotfiles/commit/0cdf1ab35621d2b1d14982e5a174dbda01584df9))
* add lazydocker install ([5a27e59](https://github.com/asenetcky/fedora-dotfiles/commit/5a27e593ad0163a2540bae210ee91ca941f6e645))
* add lazygit install ([d05eb4b](https://github.com/asenetcky/fedora-dotfiles/commit/d05eb4b6f48ebfe5e35f22a7ab23162359c97710))
* add media codecs ([569ff7e](https://github.com/asenetcky/fedora-dotfiles/commit/569ff7e6154749ee78b7795d99521838ee1e7c2a))
* add opencode install/ remove comments ([30b7211](https://github.com/asenetcky/fedora-dotfiles/commit/30b7211522fe2371d86c3f55b1312a357646aed3))
* add opencode to path ([4e0042c](https://github.com/asenetcky/fedora-dotfiles/commit/4e0042c0a40fbe41310512ee213f1739974c3e83))
* add podman typst container compile alias ([0c9d7be](https://github.com/asenetcky/fedora-dotfiles/commit/0c9d7be9454e47293b86cf797ae58bac97a62979))
* add silverblue post install ([19977e0](https://github.com/asenetcky/fedora-dotfiles/commit/19977e082deb69f942b6348e0a50b4f85bcb1c39))
* add typsetter for typst ([68a91df](https://github.com/asenetcky/fedora-dotfiles/commit/68a91df6b0ca65bc29f288e76e4689693ef5a56a))
* add uvx marimo alias ([c9db88f](https://github.com/asenetcky/fedora-dotfiles/commit/c9db88fffcc6feebb54fad915a30380410c44831))
* addd copilot cli ([22dbba6](https://github.com/asenetcky/fedora-dotfiles/commit/22dbba67156dc95293d3435c2c98e70dbb49b3e1))
* implement orchestrated setup for Fedora Silverblue ([1b75269](https://github.com/asenetcky/fedora-dotfiles/commit/1b75269a58ade92c7fa293d2544b9aabdb7ffa03))
* replace typst compile with general typst cli wrapper ([116de53](https://github.com/asenetcky/fedora-dotfiles/commit/116de5324fa58be42f5f0df81120b6f59cafff03))
* setup 1password and vscode flatpak ([112d935](https://github.com/asenetcky/fedora-dotfiles/commit/112d935af1a7d01c61717a88ae07b26c7b47c813))
* setup vscode flatpak ([c021925](https://github.com/asenetcky/fedora-dotfiles/commit/c021925fae50faaac178bf48bc4d69ce6790e80a))
* split out dnf from rpm-ostree ([f700402](https://github.com/asenetcky/fedora-dotfiles/commit/f70040277b7228aef331c34ace8e40cf43be7757))
* update gitconfig ([4735fec](https://github.com/asenetcky/fedora-dotfiles/commit/4735fec0d6c4feb35ed1dd0398136f79884383bc))
* update gitignore and setup ([ccd448b](https://github.com/asenetcky/fedora-dotfiles/commit/ccd448b7f6d8aaee91eed2ad6d46766f24258cea))
* update GNOME settings and add maintenance documentation ([bf1db70](https://github.com/asenetcky/fedora-dotfiles/commit/bf1db70789781873fc85a787e292d54f87ef3d01))
* update install ([576e696](https://github.com/asenetcky/fedora-dotfiles/commit/576e6967d0bb94d255a5dcec9b5b8360c48e092b))
* update install scripts ([d2c7cec](https://github.com/asenetcky/fedora-dotfiles/commit/d2c7cec2a1f2c3a2ff44060041acd899f247ce96))
* update signing key ([e240800](https://github.com/asenetcky/fedora-dotfiles/commit/e24080083d318958fdd6f8a27db96aa696d59ec9))
* vscode access to tailscale ([5d9cbc0](https://github.com/asenetcky/fedora-dotfiles/commit/5d9cbc00228c455a37b45c1a7876912ab1e658d3))
* vscode and 1password flatpak integration ([939d948](https://github.com/asenetcky/fedora-dotfiles/commit/939d948da92b775d52f5776c173e4623af46cfb5))


### Bug Fixes

* make setup.sh location-aware using absolute paths ([276f609](https://github.com/asenetcky/fedora-dotfiles/commit/276f609766651fa5ef1711b6df8ca371858fdfed))
* resolve syntax errors in rpm-ostree commands and standardize logging ([c9d9d00](https://github.com/asenetcky/fedora-dotfiles/commit/c9d9d009505a200e398732f023f420489c76232d))

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
