#!/usr/bin/env bash
# Create every symlink from the repository into $HOME. Safe to re-run.

if [ -z "${DOTFILES:-}" ] || ! declare -f link >/dev/null 2>&1; then
    . "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"
fi

info "Linking the *.symlink files into \$HOME"
for file in "$DOTFILES"/*/*.symlink; do
    [ -e "$file" ] || continue
    link "$file" "$HOME/.$(basename "$file" .symlink)"
done

info "Linking the XDG configuration"
link "$DOTFILES/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
link "$DOTFILES/config/matplotlib/matplotlibrc" "$HOME/.config/matplotlib/matplotlibrc"

# Neovim uses the lazy.nvim configuration in nvim/, while vim keeps using
# ~/.vimrc. init.lua and lua/ are linked separately so that coc-settings.json
# can stay in coc/ and ~/.config/nvim remains a real directory.
info "Linking the Neovim configuration (lazy.nvim)"
if [ -e "$HOME/.config/nvim/init.vim" ]; then
    # init.vim and init.lua cannot coexist, Neovim refuses to start
    backup "$HOME/.config/nvim/init.vim"
fi
mkdir -p "$HOME/.config/nvim"
link "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"
link "$DOTFILES/nvim/lua" "$HOME/.config/nvim/lua"
link "$DOTFILES/coc/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

