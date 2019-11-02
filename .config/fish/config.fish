set -xg PATH ~/.local/bin ~/.cargo/bin ~/.local/kitty.app/bin $PATH

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

alias vi "nvim"
alias vim "nvim"
alias svi "sudo -E nvim"

alias ls "exa --icons"
alias l "exa -lF --icons --git"
alias la "exa -laF --icons --git"

alias cat "bat"

alias ga "git add"
alias gc "git commit"
alias gca "git commit -a"
alias gco "git checkout --"
alias gd "git diff"
alias gl "git pull"
alias glg "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gp "git push"
alias grh "git reset HEAD"
alias gs "git status"

alias update "yadm commit -am update; and yadm push"

set fish_greeting
starship init fish | source
