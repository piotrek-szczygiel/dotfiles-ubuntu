set -gx PATH ~/.local/bin $PATH
set -gx LD_LIBRARY_PATH /usr/local/lib

set -gx EDITOR nvim
set -gx VISUAL nvim


alias vi "nvim"
alias vim "nvim"
alias svi "sudo -E nvim"

alias l "exa"
alias ls "exa"
alias ll "exa -lF --git"
alias la "exa -laF --git"

alias cat "batcat"
alias fd "fdfind"

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

if grep -qEi "(Microsoft|WSL)" /proc/version
    set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

    alias e "explorer.exe"
    set sshd_status (service ssh status)
    if string match -q -- "*is not running*" $sshd_status
    sudo service ssh --full-restart
    end

    set -x SSH_AUTH_SOCK $HOME/.ssh/agent.sock
    ssh-agent-relay.sh
end

set fish_greeting
starship init fish | source
