#! /bin/bash
# Dotfiles setup

echo "Backing up current .gitconfig"
mv ~/.gitconfig ~/.gitconfig.bak

echo "Backing up current .bashrc"
mv ~/.bashrc ~/.bashrc.bak

echo "stow dotfiles"
cd ~/dotfiles
stow .
