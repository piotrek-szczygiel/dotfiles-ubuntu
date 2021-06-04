# WSL dotfiles

Currently using Ubuntu as a distribution.

## Setup

 - Update Ubuntu 20.04 to 20.10

```
$ sudo sed --in-place 's/focal/groovy/g' /etc/apt/sources.list
$ sudo apt update
$ sudo apt upgrade
```

 - Install my configuration

```
$ bash <(curl -s https://raw.githubusercontent.com/piotrek-szczygiel/dotfiles-wsl/master/wsl.sh)
```
