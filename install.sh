#!/bin/bash

mkdir ~/.vim/undo

if [ ! -d ~/.antigen ]; then
    echo "Installing antigen (zsh)"
    git clone https://github.com/zsh-users/antigen.git ~/.antigen
else
    cd ~/.antigen; git pull
fi 

echo "Installing tpm"
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing dotfiles"
source ~/.dotfiles/install/link.sh

if [ -d /usr/share/konsole ]; then
    sudo cp ~/.dotfiles/konsole/Wombat.colorscheme /usr/share/konsole/
fi

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
cd ~/.vim/bundle/YouCompleteMe; python install.py
# cd ~/.vim/bundle/YouCompleteMe; ./install.sh --clang-completer

echo "If you want to use dictionaries in vim,"
echo "you should also instacl sdcv and stardict"
echo "dictionaries. On archlinux do:"
echo "sudo pacman sdcv stardict-oald stardict-wordnet"
