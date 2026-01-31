# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
