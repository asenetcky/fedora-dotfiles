#!/bin/bash
set -e

echo ">>> Cleaning up System..."

echo "Pruning unused Flatpak runtimes..."
flatpak uninstall --unused -y

echo "Cleaning up rpm-ostree metadata and cache..."
sudo rpm-ostree cleanup -m
sudo rpm-ostree cleanup -b

echo ">>> Step 99 (Cleanup) Complete."
