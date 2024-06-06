#!/bin/env/ bash
# a simple bootstrapper by @WhiskeyTuesday
# sets up basic terminal utilities and personal dotfiles in any debian system
# must be run from the dir containing the dotfiles

set -e # this tells the shell to exit if any simple commands fail

echo 'Performing update and upgrade'
sudo apt-get -y update >> apt-log
sudo apt-get -y upgrade >> apt-log

echo 'Installing tools'
sudo apt-get -y install >> apt-log  \
htop                                \
nvtop                               \
git                                 \
snapd                               \
docker.io                           \
procps                              \
wget                                \
curl                                \
vim            	                    \
neofetch                            \
cool-retro-term                     \
tmux                                \
fish                                \
zsh                                 \
w3m                                 \
links                               \
tree                                \
exfat-fuse                          \
gcc                                 \
build-essential                     \
p7zip-full                          \
youtube-dl                          \
progress                            \
vlc                                 \
cloc                                \
firefox                             \
discord                             \
wordgrinder

echo 'Installing rust'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install     \
exa               \
porsmo            \
bob-nvim          \
gitui             \
irust             \
cargo-info        \
cargo-watch       \
cargo-audit       \
cargo-edit        \
speedtest-rs      \
wiki-tui          \
bat               \
ripgrep           \
fd-find           \
mise

echo 'Installing stable nvim'
bob use stable

echo 'Linking dotfiles'
[ -f zshrc ] && ln -fs "$(pwd)/zshrc" ~/.zshrc
[ -f vimrc ] && ln -fs "$(pwd)/vimrc" ~/.vimrc
[ -f tmux.conf ] && ln -fs "$(pwd)/tmux.conf" ~/.tmux.conf
[ -f config.fish ] && ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish
[ -f init.vim ] && ln -fs "$(pwd)/init.vim" ~/.config/nvim/init.vim
[ -f coc-settings.json ] && ln -fs "$(pwd)/coc-settings.json" ~/.config/nvim/coc-settings.json
[ -d fish_fns ] && ln -fs "$(pwd)/fish_fns" ~/.config/fish/functions

# These files are not in the public repo, contain personal information
[ -d secretconf ] &&
  ln -fs "$(pwd)/secretconf/secretconf" ~/.secretconf &&
  ln -fs "$(pwd)/secretconf/secretconf.fish" ~/.secretconf.fish

echo 'Intalling vundle'
[ ! -d ~/.vim/bundle/Vundle.vim ] && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 'Installing vim plugins and creating promptline.sh'
vim +PluginInstall +qall
vim +"PromptlineSnapshot ~/.promptline.sh airline" +qall

echo 'Installing neovim plugins'
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall

echo 'installing brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#echo 'installing fvm'
#brew tap leoafarias/fvm
#brew install fvm

# echo 'installing flutter'
# TODO

echo 'installing spotify'
sudo snap install spotify

echo "Ta-ta for now! Don't forget chsh \& .machineconf if applicable."
echo "Android studio can be installed from https://developer.android.com/studio"
echo "flutter doctor --android-licenses is probably a good idea too."

# NOTES
# either change vim theme or include a powerline font?
# terminal emulator setup?
