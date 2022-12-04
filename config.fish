set -x EDITOR nvim
if set -q COLORSCHEMES_DIR && not set -q TMUX
  set TERM xterm-256color
end

alias gcl 'git clone'
alias gap 'git add -p'
alias ga 'git add'
alias gc 'git commit -m'
alias gcl 'git clone'
alias gs 'git status'
alias gd 'git diff'

alias v 'nvim'
alias vr 'nvim -R'

alias wg 'wordgrinder'

alias ll 'ls -l'
alias cls 'clear; and ls'
alias ccd 'clear; and cd'

alias noc 'nordvpn connect'
alias nos 'nordvpn status'
alias nod 'nordvpn disconnect'

alias bat 'batcat'
alias b 'batcat'

alias fd 'fdfind'

# PATH variables
set PATH $PATH /usr/local/bin
set ANDROID_HOME $HOME/Android/Sdk
set JAVA_HOME $HOME/android-studio/jre
set PATH $PATH $ANDROID_HOME/emulator
set PATH $PATH $ANDROID_HOME/tools
set PATH $PATH $ANDROID_HOME/tools/bin
set PATH $PATH $ANDROID_HOME/platform-tools

# Fish settings
set fish_key_bindings fish_vi_key_bindings
set fish_greeting 'What are you working on?'

# External sources
if test -e ~/.machineconf.fish
  source ~/.machineconf.fish
end

if test -e ~/.secretconf.fish
  source ~/.secretconf.fish
end

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
