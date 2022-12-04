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
wget                                \
curl                                \
vim            	                    \
neovim                              \
neofetch                            \
cool-retro-term                     \
tmux                                \
fish                                \
zsh                                 \
w3m                                 \
links                               \
tree                                \
exfat-fuse                          \
build-essential                     \
p7zip-full                          \
youtube-dl                          \
progress                            \
vlc                                 \
cloc                                \
firefox                             \
chromium-bsu                        \
wordgrinder                         \
bat                                 \
ripgrep                             \
fd-find

echo 'Installing rust'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo 'Linking dotfiles'
[ -f zshrc ] && ln -fs "$(pwd)/zshrc" ~/.zshrc
[ -f vimrc ] && ln -fs "$(pwd)/vimrc" ~/.vimrc
[ -f tmux.conf ] && ln -fs "$(pwd)/tmux.conf" ~/.tmux.conf
[ -f config.fish ] && ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish
[ -f init.vim ] && ln -fs "$(pwd)/config.fish" ~/.config/nvim/init.vim
[ -f coc-settings.json ] && ln -fs "$(pwd)/config.fish" ~/.config/nvim/coc-settings.json

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
nvim +PlugInstall +qall

echo 'installing brew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'installing flutter'
sudo snap install flutter --classic
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev -y


echo 'installing fvm'
brew tap leoafarias/fvm
brew install fvm

echo 'installing n (an alternative node version manager)'
curl -L https://bit.ly/n-install | bash

echo "Ta-ta for now! Don't forget chsh \& .machineconf if applicable."
echo "Android studio can be installed from https://developer.android.com/studio"
echo "flutter doctor --android-licenses is probably a good idea too."

# NOTES
# either change vim theme or include powerline font?
# gnometerm setup or pick a different terminal and set that up?
