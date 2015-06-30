#!/bin/bash

echo "Removing vim directory"
rm -rf ~/.vim

echo "Removing dotfiles"
rm -f ~/.vimrc
rm -f ~/.gitconfig
rm -f ~/.tmux.conf
rm -f ~/.zshrc
rm -f ~/.screenrc
