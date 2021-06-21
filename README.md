# WSL dotfiles

Currently using Ubuntu as a distribution.

## (WSL) Update Ubuntu 20.04 to 20.10

```bash
sudo sed --in-place 's/focal/groovy/g' /etc/apt/sources.list
```

## Bootstrap configuration

```bash
bash <(curl -s https://raw.githubusercontent.com/piotrek-szczygiel/dotfiles-wsl/master/wsl.sh)
```
