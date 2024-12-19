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

alias b 'bat'

alias fd 'fdfind'

# PATH variables
set PATH /usr/local/bin $PATH # Unmanaged local binaries before all else
set ANDROID_HOME $HOME/Android/Sdk
set JAVA_HOME $HOME/android-studio/jre
set PATH $PATH $ANDROID_HOME/emulator
set PATH $PATH $ANDROID_HOME/tools
set PATH $PATH $ANDROID_HOME/tools/bin
set PATH $PATH $ANDROID_HOME/platform-tools
set PATH $PATH $HOME/.local/share/bob/nvim-bin
set PATH $PATH $HOME/.dotnet/tools # .NET Core Global Tools

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

# pnpm
set -gx PNPM_HOME "/home/ers/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/ers/anaconda3/bin/conda
    eval /home/ers/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end

# Set the prompt
function fish_prompt --description 'Write out the prompt'
    # set the shell level
    # we subtract 2 because the first shell the login shell
    # and the second shell should be tmux
    # if you see a -1 you should launch tmux, if you see a 0
    # you're in a console tty I guess. If you see a number
    # greater than 1 you're in some kind of shell within a
    # shell, like nix-shell for instance
    printf '%s ' (math $SHLVL - 2)
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

  # Color the prompt differently when we're root
  set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

  # Write pipestatus
  # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
  set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

  echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end

# <<< conda initialize <<<
# ~/.cargo/bin/mise activate fish | source
