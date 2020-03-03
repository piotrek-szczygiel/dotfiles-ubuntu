#!/bin/bash

if [ ! -f "/etc/arch-release" ]; then
    echo "This script only works on Arch Linux" 1>&2
    exit 1
fi

set -e

function log() {
    echo -e "\033[1;33m$1\033[0m"
}

log "Enabling colored output"
sudo sed -i '/Color/s/^#//' /etc/pacman.conf

# log "Removing fakeroot-tcp"
# sudo pacman -Rns --noconfirm fakeroot-tcp || true

log "Updating system"
sudo pacman -Syuq --noconfirm

sudo pacman -Sq --noconfirm git
sudo pacman -Sq base-devel

pushd /tmp
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si --noconfirm
popd
popd

yay install -Sq --noconfirm yadm

yadm clone https://github.com/piotrek-szczygiel/dotfiles-wsl

