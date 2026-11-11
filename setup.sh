#!/bin/bash

# Master Setup Script for Fedora dotfiles (Silverblue/atomic or Workstation).
# On atomic systems it orchestrates the setup across multiple reboots.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# shellcheck source=scripts/common.sh
source "$SCRIPT_DIR/scripts/common.sh"

STATE_FILE="$HOME/.config/dotfiles-setup-state"
mkdir -p "$(dirname "$STATE_FILE")"

# Ordered list of steps (script names without .sh)
STEPS=(
  01-rpmfusion
  02-layered-pkgs
  03-userspace
  04-flatpak
  05-dotfiles
  99-cleanup
)

# Steps that need a reboot afterwards on atomic systems
needs_reboot() {
  is_atomic && { [ "$1" = "01-rpmfusion" ] || [ "$1" = "02-layered-pkgs" ]; }
}

# State file holds the last completed step (or INIT / ALL_DONE).
get_state() {
  local state="INIT"
  [ -f "$STATE_FILE" ] && state="$(cat "$STATE_FILE")"
  # Migrate state values from older versions of this script
  case "$state" in
  01_DONE) state="01-rpmfusion" ;;
  02_DONE) state="02-layered-pkgs" ;;
  esac
  echo "$state"
}

set_state() {
  echo "$1" >"$STATE_FILE"
}

CURRENT_STATE="$(get_state)"
log_info "Detected variant: $VARIANT"
log_info "Current setup state: $CURRENT_STATE"

if [ "$CURRENT_STATE" = "ALL_DONE" ]; then
  echo "Setup is already marked as complete."
  read -p "Do you want to reset the state and start over? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    set_state "INIT"
    echo "State reset to INIT. Run the script again to start."
  fi
  exit 0
fi

# Find where to resume
START=0
if [ "$CURRENT_STATE" != "INIT" ]; then
  for i in "${!STEPS[@]}"; do
    if [ "${STEPS[$i]}" = "$CURRENT_STATE" ]; then
      START=$((i + 1))
      break
    fi
  done
  if [ "$START" -eq 0 ]; then
    log_error "Unknown state: $CURRENT_STATE (delete $STATE_FILE to start over)"
    exit 1
  fi
fi

for ((i = START; i < ${#STEPS[@]}; i++)); do
  step="${STEPS[$i]}"
  echo "---------------------------------------------------"
  log_info "Running step $step"
  if ! bash "$SCRIPT_DIR/scripts/$step.sh"; then
    log_error "Step $step failed. Fix the problem and re-run ./setup.sh to resume."
    exit 1
  fi
  set_state "$step"

  if needs_reboot "$step"; then
    echo "---------------------------------------------------"
    log_success "Step $step finished."
    echo "A reboot is required before continuing."
    echo "After rebooting, run ./setup.sh again to resume."
    echo "---------------------------------------------------"
    read -p "Reboot now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      systemctl reboot
    fi
    exit 0
  fi
done

set_state "ALL_DONE"
echo "---------------------------------------------------"
log_success "All steps completed successfully!"
echo "You may need to log out and back in for some changes (like groups or fonts) to take effect."
echo "---------------------------------------------------"
