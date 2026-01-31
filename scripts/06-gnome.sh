#!/bin/bash
set -e

echo ">>> Setting up Gnome Settings..."

SETTINGS_FILE="$(dirname "$0")/../gnome/dconf-settings.ini"

if [ -f "$SETTINGS_FILE" ]; then
    echo "Restoring Gnome settings from $SETTINGS_FILE..."
    # To update the settings file from current system:
    # dconf dump / > "$SETTINGS_FILE"
    #
    # We use 'load /' because we dumped from root '/'. 
    # Warning: This overwrites current settings.
    dconf load / < "$SETTINGS_FILE"
    echo "Gnome settings restored."
else
    echo "No settings file found at $SETTINGS_FILE. Skipping."
fi

echo ">>> Step 06 Complete."
