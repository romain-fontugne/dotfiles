#!/bin/bash

echo "Installing dotfiles"
source install/link.sh

echo "Installing vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "Install flake8"
sudo pip install flake8

echo "Compiling YCM"
cd ~/.vim/bundle/YouCompleteMe; ./install.sh
# cd ~/.vim/bundle/YouCompleteMe; ./install.sh --clang-completer

