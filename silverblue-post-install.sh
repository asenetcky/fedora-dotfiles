#!/bin/bash

# Fedora Silverblue Post install

### doco here: https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/

## Enabling RPM Fusions repos
sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && reboot

## Major Fedora Updates
sudo rpm-ostree update --uninstall rpmfusion-free-release --uninstall rpmfusion-nonfree-release --install rpmfusion-free-release --install rpmfusion-nonfree-release && reboot

## add lazygit
### copr repo url: https://copr.fedorainfracloud.org/coprs/dejan/lazygit/

sudo curl https://copr.fedorainfracloud.org/coprs/dejan/lazygit/repo/fedora-43/dejan-lazygit-fedora-43.repo -o /etc/yum.repos.d/lazygit.repo
sudo rpm-ostree install lazygit
