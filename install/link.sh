#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "creating symlinks"
linkables=$( ls -1 -d **/*.symlink )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".symlink" )"
    echo "creating symlink for $file"
    ln -s $DOTFILES/$file $target
done

mkdir $HOME/.config/matplotlib
ln -s $DOTFILES/config/matplotlib/matplotlibrc $HOME/.config/matplotlib/matplotlibrc

mkdir $HOME/.config/kitty
ln -s $DOTFILES/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
