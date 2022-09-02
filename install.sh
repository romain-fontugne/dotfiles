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

cd ~/.dotfiles
echo "Installing dotfiles"
source ~/.dotfiles/install/link.sh

echo "Installing patched fonts"
mkdir -p ~/.local/share/fonts
cp ~/.dotfiles/fonts/'Droid Sans Mono Nerd Font Complete Mono.otf' ~/.local/share/fonts/

if [ -d /usr/share/konsole ]; then
    sudo cp ~/.dotfiles/konsole/Wombat.colorscheme /usr/share/konsole/
fi

echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing vim plugins"
nvim +PlugInstall +qall

echo "If you want to use dictionaries in vim,"
echo "you should also install sdcv and stardict"
echo "dictionaries. On archlinux do:"
echo "sudo pacman sdcv stardict-oald stardict-wordnet"

