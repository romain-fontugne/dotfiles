#!/bin/bash

echo "Removing vim directory"
rm -rf ~/.vim

echo "Removing antigen directory"
rm -rf ~/.antigen

echo "Removing dotfiles"
rm -f ~/.vimrc
rm -f ~/.gitconfig
rm -f ~/.tmux.conf
rm -f ~/.zshrc
rm -f ~/.screenrc
