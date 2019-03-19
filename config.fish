set -x EDITOR vim

alias gcl 'git clone'
alias ga 'git add'
alias gc 'git commit -m'
alias gs 'git status'
alias gd 'git diff'

alias v 'vim'
alias vr 'vim -R'
alias ll 'ls -l'
alias cls 'clear; and ls'
alias ccd 'clear; and cd'

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

# External sources
if test -e ~/.machineconf.fish
  source ~/.machineconf.fish
end

if test -e ~/.secretconf.fish
  source ~/.secretconf.fish
end
