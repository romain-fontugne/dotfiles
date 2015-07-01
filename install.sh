#!/bin/bash

if hash zsh 2>/dev/null; then
    zsh
else
    echo "Install zsh"
    if hash pacman 2>/dev/null; then
        sudo pacman -Sy zsh
    else
        sudo apt-get install zsh
    fi
    zsh
fi
chsh -s $(which zsh)

if [ ! -d ~/.antigen ]; then
    echo "Installing antigen (zsh)"
    git clone https://github.com/zsh-users/antigen.git ~/.antigen
else
    cd ~/.antigen; git pull
fi 

echo "Installing dotfiles"
source install/link.sh

echo "Installing vundle"
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    cd ~/.vim/bundle/Vundle.vim; git pull
fi

echo "Installing vim plugins"
vim +PluginInstall +qall

echo "Install flake8"
if hash pip2 2>/dev/null; then
    sudo pip2 install flake8
else
    sudo pip install flake8
fi

echo "Compiling YCM"
cd ~/.vim/bundle/YouCompleteMe; ./install.sh
# cd ~/.vim/bundle/YouCompleteMe; ./install.sh --clang-completer

