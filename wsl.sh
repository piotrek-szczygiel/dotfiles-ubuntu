#!/bin/bash

if [ ! -f "/etc/arch-release" ]; then
    echo "This script only works on Arch Linux" 1>&2
    exit 1
fi

set -e

function echo_yellow() {
    echo -e "\033[1;33m$1\033[0m"
}

function pacman_install() {
    echo_yellow "Installing $1"
    sudo pacman -Sq --noconfirm "$1"
}

function yay_install() {
    echo_yellow "Installing $1"
    yay -Sq --noconfirm "$1"
}

echo_yellow "Enabling colored output"
sudo sed -i '/Color/s/^#//' /etc/pacman.conf

echo_yellow "Removing fakeroot-tcp"
sudo pacman -Rns --noconfirm fakeroot-tcp || true

echo_yellow "Updating system"
sudo pacman -Syuq --noconfirm

pacman_install base-devel
pacman_install git

pushd /tmp
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si --noconfirm
popd
popd

yay_install yadm

yadm clone https://github.com/piotrek-szczygiel/dotfiles-wsl

