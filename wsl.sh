#!/bin/bash

set -e

function log() {
    echo -e "\033[1;33m$1\033[0m"
}

log "Updating system"
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
    bat \
    curl \
    exa \
    fd-find \
    fish \
    jq \
    keychain \
    neovim \
    python3 \
    python3-pip \
    python3-pynvim \
    ripgrep

sudo apt install -y yadm
yadm clone https://github.com/piotrek-szczygiel/dotfiles-wsl

log "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:piotrek-szczygiel/dotfiles-wsl.git"

log "Installing fish prompt"
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

log "Installing fish plugins"
fish -c fisher update

log "Installing git-delta"
wget -q -O /tmp/delta.deb $(curl -s https://api.github.com/repos/dandavison/delta/releases/latest \
    | jq --raw-output '.assets[] | select(.name | endswith("amd64.deb")).browser_download_url' | tail -n 1)
sudo dpkg -i /tmp/delta.deb

log "Adding Windows fonts"
sudo tee /etc/fonts/local.conf > /dev/null <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
    <dir>/mnt/c/Windows/Fonts</dir>
</fontconfig>
EOF

log "Installing neovim plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

log "Issue 'chsh -s /usr/bin/fish' to change your shell to fish"
