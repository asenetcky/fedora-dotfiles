#!/bin/bash

# Common utility functions for dotfiles setup

# ANSI Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
cmd_exists() {
    command -v "$1" &> /dev/null
}

# Function to download and run a script securely (basic version)
# Usage: install_from_url "Name" "URL" [args]
install_from_url() {
    local name="$1"
    local url="$2"
    shift 2
    local args=("$@")

    if cmd_exists "$name"; then
        log_info "$name is already installed."
        return
    fi

    log_info "Installing $name..."
    local temp_script
    temp_script=$(mktemp)
    
    if curl -LsSf "$url" -o "$temp_script"; then
        sh "$temp_script" "${args[@]}"
        rm "$temp_script"
        log_success "$name installed."
    else
        log_error "Failed to download installer for $name"
        rm -f "$temp_script"
        return 1
    fi
}
