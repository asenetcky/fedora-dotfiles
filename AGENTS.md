# Agent Context: Fedora Silverblue Dotfiles

This document provides essential context for LLM agents working on this repository.

## Project Overview

A modular, state-aware orchestration system for setting up Fedora
Silverblue. It handles everything from repository configuration to userspace
tools and GNOME settings.

## Core Architecture

- **Orchestrator:** `setup.sh` is the main entry point. It manages reboots
  by tracking progress in `~/.config/dotfiles-setup-state`.
- **Modular Scripts:** Located in `scripts/`, prefixed with numbers (01-99)
  to indicate execution order.
- **Common Logic:** `scripts/common.sh` contains shared functions for logging
  (`log_info`, `log_success`, `log_error`).
- **Testing:** `tests/validate_install.sh` verifies the system state after setup.

## Setup Phases

1. **01-rpmfusion.sh**: Configures RPM Fusion repos (requires reboot).
2. **02-layered-pkgs.sh**: Uses `rpm-ostree` for system-level packages
   (requires reboot). Uses `--idempotent`.
3. **03-userspace.sh**: Installs non-system tools (uv, air, starship, quarto)
   and sets up a default toolbox.
4. **04-flatpak.sh**: Manages Flatpak apps and overrides (e.g., VS Code
   filesystem access).
5. **05-dotfiles.sh**: Uses `GNU Stow` to link configuration files.
6. **06-gnome.sh**: Restores GNOME settings via `dconf`.
7. **99-cleanup.sh**: Prunes old `rpm-ostree` deployments and Flatpak metadata.

## Tech Stack & Conventions

- **OS:** Fedora Silverblue (Immutable/Atomic).
- **Package Management:** `rpm-ostree` (system), `flatpak` (apps), `uv`
  (python), `cargo` (rust).
- **Dotfiles:** Managed via `stow`.
- **Editor:** Neovim (LazyVim) and Zed.
- **Versioning:** Follows Semantic Versioning; tracked in `CHANGELOG.md`.

## Development Guidelines

- Always use `source "$(dirname "$0")/common.sh"` in scripts for consistent logging.
- Use `--idempotent` or check for file existence before performing
  destructive/heavy operations to ensure scripts can be re-run safely.
- When adding system packages, add them to the `PKGS` array in `02-layered-pkgs.sh`.
- Update `CHANGELOG.md` and bump the version for every functional change.
