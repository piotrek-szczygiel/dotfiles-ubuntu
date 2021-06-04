#!/bin/bash

set -e

function log() {
    echo -e "\033[1;33m$1\033[0m"
}

log "Installing NTP service"
sudo apt install -y ntp
sudo service ntp restart

log "Updating system"
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
    bat \
    build-essential \
    clang \
    cmake \
    curl \
    exa \
    fd-find \
    fish \
    fzy \
    gcc \
    gdb \
    jq \
    neovim \
    openssh-server \
    python3 \
    python3-pip \
    python3-pynvim \
    ripgrep \
    socat \
    unzip \
    valgrind

sudo apt install -y yadm
yadm clone -f https://github.com/piotrek-szczygiel/dotfiles-wsl

log "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:piotrek-szczygiel/dotfiles-wsl.git"

log "Installing fish prompt"
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

log "Installing fish plugins"
fish -c "fisher update"

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

log "Configuring OpenSSH server"
SSHD_FILE=/etc/ssh/sshd_config
sudo cp $SSHD_FILE ${SSHD_FILE}.`date '+%Y-%m-%d_%H-%M-%S'`.back
sudo sed -i "/^Port/ d" $SSHD_FILE
sudo sed -i "/^ListenAddress/ d" $SSHD_FILE
sudo sed -i "/^PasswordAuthentication/ d" $SSHD_FILE
echo "ListenAddress 127.0.0.1" | sudo tee -a $SSHD_FILE > /dev/null
echo "Port 2222" | sudo tee -a $SSHD_FILE > /dev/null
echo "PasswordAuthentication yes" | sudo tee -a $SSHD_FILE > /dev/null
echo "%sudo ALL=(ALL) NOPASSWD: /usr/sbin/service ssh --full-restart" | sudo tee -a /etc/sudoers > /dev/null
sudo service ssh --full-restart

log "Installing win32yank.exe"
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /bin/win32yank.exe

log "Installing neovim plugins"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

log "Issue 'chsh -s /usr/bin/fish' to change your shell to fish"
