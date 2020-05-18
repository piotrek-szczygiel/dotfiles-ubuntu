# WSL dotfiles

## Setup

```
wsl --set-default-version 2
scoop install archwsl
scoop hold archwsl
arch

[root]# passwd
[root]# EDITOR=vim visudo
    %wheel      ALL=(ALL) ALL

[root]# useradd -m -G wheel -s /bin/bash wsl
[root]# passwd wsl
[root]# exit

arch config --default-user wsl
arch

[wsl]$ sudo pacman-key --init
[wsl]$ sudo pacman-key --populate
[wsl]$ curl -s https://raw.githubusercontent.com/piotrek-szczygiel/dotfiles-wsl/master/wsl.sh | sh
```
