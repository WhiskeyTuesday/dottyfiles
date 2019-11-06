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
curl                                \
vim            	                    \
tmux                                \
fish                                \
zsh                                 \
w3m                                 \
links                               \
tree

echo 'Linking dotfiles'
[ -f zshrc ] && ln -fs "$(pwd)/zshrc" ~/.zshrc
[ -f vimrc ] && ln -fs "$(pwd)/vimrc" ~/.vimrc
[ -f tmux.conf ] && ln -fs "$(pwd)/tmux.conf" ~/.tmux.conf
[ -f config.fish ] && ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish

# These files are not in the public repo, contain personal information
[ -d secretconf ] &&
  ln -fs "$(pwd)/secretconf/secretconf" ~/.secretconf &&
  ln -fs "$(pwd)/secretconf/secretconf.fish" ~/.secretconf.fish

echo 'Intalling vundle'
[ ! -d ~/.vim/bundle/Vundle.vim ] && \
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo 'Creating promptline.sh'
vim +PluginInstall +qall
vim +"PromptlineSnapshot ~/.promptline.sh airline" +qall

echo "Ta-ta for now! Don't forget chsh zsh \& .machineconf if applicable."
