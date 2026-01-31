#!/bin/bash

# Master Setup Script for Fedora Silverblue Dotfiles
# Orchestrates the setup across multiple reboots.

STATE_FILE="$HOME/.config/dotfiles-setup-state"
mkdir -p "$(dirname "$STATE_FILE")"

# Ensure scripts are executable
chmod +x scripts/*.sh

get_state() {
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "INIT"
    fi
}

set_state() {
    echo "$1" > "$STATE_FILE"
}

CURRENT_STATE=$(get_state)

echo "Current Setup State: $CURRENT_STATE"

case "$CURRENT_STATE" in
    "INIT")
        ./scripts/01-rpmfusion.sh
        if [ $? -eq 0 ]; then
            set_state "01_DONE"
            echo "---------------------------------------------------"
            echo "Step 01 (RPM Fusion) finished successfully."
            echo "A system reboot is required to activate the new repositories."
            echo "Please reboot and run this script again."
            echo "---------------------------------------------------"
            read -p "Reboot now? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                systemctl reboot
            fi
        else
            echo "Step 01 failed."
            exit 1
        fi
        ;;
    
    "01_DONE")
        ./scripts/02-layered-pkgs.sh
        if [ $? -eq 0 ]; then
            set_state "02_DONE"
            echo "---------------------------------------------------"
            echo "Step 02 (Layered Packages) finished successfully."
            echo "A system reboot is required to boot into the new deployment."
            echo "Please reboot and run this script again."
            echo "---------------------------------------------------"
            read -p "Reboot now? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                systemctl reboot
            fi
        else
            echo "Step 02 failed."
            exit 1
        fi
        ;;

    "02_DONE")
        # Run remaining steps sequentially as they don't require reboots between them
        echo "Running Userspace Setup (Step 03)..."
        ./scripts/03-userspace.sh
        
        echo "Running Flatpak Setup (Step 04)..."
        ./scripts/04-flatpak.sh
        
        echo "Running Dotfiles Stow (Step 05)..."
        ./scripts/05-dotfiles.sh
        
        set_state "ALL_DONE"
        echo "---------------------------------------------------"
        echo "All steps completed successfully!"
        echo "You may need to log out and back in for some changes (like groups or fonts) to take effect."
        echo "---------------------------------------------------"
        ;;
        
    "ALL_DONE")
        echo "Setup is already marked as complete."
        read -p "Do you want to reset the state and start over? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            set_state "INIT"
            echo "State reset to INIT. Run the script again to start."
        fi
        ;;
    
    *)
        echo "Unknown state: $CURRENT_STATE"
        exit 1
        ;;
esac
