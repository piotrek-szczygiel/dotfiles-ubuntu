set -xg PATH ~/.local/bin ~/.cargo/bin $PATH

set -gx EDITOR nvim
set -gx VISUAL nvim

alias vi "nvim"
alias vim "nvim"
alias svi "sudo -E nvim"

alias ls "exa"
alias l "exa -lF --git"
alias la "exa -laF --git"

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
