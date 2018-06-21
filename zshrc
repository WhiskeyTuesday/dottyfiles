[ -f ~/.machineconf ] && source ~/.machineconf
[ -f ~/.secretconf ] && source ~/.secretconf
[ -f ~/.promptline.sh ] && source ~/.promptline.sh

export EDITOR='vim'

# General aliases
alias tree='tree --dirsfirst'

# Git aliases
alias gcl='git clone'
alias gf='git fetch'
alias gm='git merge'
alias gp='git push'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit -am'
alias gs='git status'
alias gd='git diff'

# Vim aliases
alias v='vim'
alias vr='vim -R'

# rbEnv stuff
export PATH="$HOME/.rbenv/bin:$PATH" # add rubyenv to the path
eval "$(rbenv init -)"
