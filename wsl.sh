#!/bin/bash

set -e

function log() {
    echo -e "\033[1;33m$1\033[0m"
}

log "Updating system"
sudo sed --in-place 's/focal/groovy/g' /etc/apt/sources.list
sudo apt update
sudo apt upgrade

sudo apt install -y bat
sudo apt install -y exa
sudo apt install -y fd-find
sudo apt install -y fish
sudo apt install -y jq
sudo apt install -y neovim
sudo apt install -y python3-pynvim
sudo apt install -y ripgrep

sudo apt install -y yadm
yadm clone https://github.com/piotrek-szczygiel/dotfiles-wsl

log "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:piotrek-szczygiel/dotfiles-wsl.git"

log "Installing neovim plugins"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim '+PlugUpdate' '+PlugClean!' '+PlugUpdate' '+qall'

log "Installing fish plugins"
fish -c fisher update

log "Done!"
log "Issuing 'chsh -s /usr/bin/fish' to change your shell to fish"
chsh -s /usr/bin/fish

log "Installing git-delta (might fail)"
wget -q -O /tmp/delta.deb $(curl -s https://api.github.com/repos/dandavison/delta/releases/latest \
    | jq --raw-output '.assets[] | select(.name | endswith("amd64.deb")).browser_download_url' | tail -n 1)
sudo dpkg -i /tmp/delta.deb
