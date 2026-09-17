#!/usr/bin/env bash
# One shot installer for the dotfiles. Every step is idempotent, so the
# script is safe to re-run to pick up new configuration.
#
# Usage:
#   ./install.sh                install everything
#   ./install.sh --links-only   only (re)create the symlinks
#   ./install.sh --no-plugins   skip the zsh/tmux/vim/neovim plugin downloads
#
# Anything that gets overwritten is moved to ~/.dotfiles-backup/<timestamp>/

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES
. "$DOTFILES/install/lib.sh"

INSTALL_PLUGINS=1
LINKS_ONLY=0

for arg in "${@:-}"; do
    case "$arg" in
        "") ;;
        --no-plugins) INSTALL_PLUGINS=0 ;;
        --links-only) LINKS_ONLY=1 ;;
        -h|--help) sed -n '2,9p' "$0" | cut -c 3-; exit 0 ;;
        *) fail "unknown option: $arg (try --help)" ;;
    esac
done

create_dirs() {
    info "Creating the local directories"
    mkdir -p "$HOME/.vim/undo" "$HOME/.local/share/fonts" "$HOME/.config"
}

install_links() {
    . "$DOTFILES/install/link.sh"
}

install_fonts() {
    info "Installing the patched fonts"
    cp -n "$DOTFILES"/fonts/*.otf "$HOME/.local/share/fonts/" 2>/dev/null || true
    if have fc-cache; then
        fc-cache -f "$HOME/.local/share/fonts" >/dev/null
    fi
}

install_konsole() {
    [ -d /usr/share/konsole ] || return 0
    info "Installing the konsole colorscheme"
    sudo cp "$DOTFILES/konsole/Wombat.colorscheme" /usr/share/konsole/
}

install_antigen() {
    if [ -d "$HOME/.antigen" ]; then
        info "Updating antigen (zsh)"
        git -C "$HOME/.antigen" pull --quiet || warn "could not update antigen"
    else
        info "Installing antigen (zsh)"
        git clone --quiet https://github.com/zsh-users/antigen.git "$HOME/.antigen"
    fi
}

install_tpm() {
    if [ -d "$HOME/.tmux/plugins/tpm" ]; then
        info "Updating tpm (tmux)"
        git -C "$HOME/.tmux/plugins/tpm" pull --quiet || warn "could not update tpm"
    else
        info "Installing tpm (tmux)"
        git clone --quiet https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
    step "press prefix + I inside tmux to install the tmux plugins"
}

install_vim_plugins() {
    # Vim still uses vim-plug through ~/.vimrc, Neovim uses lazy.nvim
    have vim || return 0
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        info "Installing vim-plug (vim)"
        curl -fsSLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    info "Installing the vim plugins"
    vim +PlugInstall +qall >/dev/null || warn "vim +PlugInstall reported an error"
}

install_nvim_plugins() {
    if ! have nvim; then
        warn "neovim is not installed, skipping the lazy.nvim sync"
        return 0
    fi
    info "Syncing the Neovim plugins with lazy.nvim"
    # lazy.nvim bootstraps itself from nvim/init.lua on the first run
    nvim --headless "+Lazy! sync" +qa || warn "the lazy.nvim sync reported an error"
    if have node; then
        info "Building the coc.nvim extensions"
        nvim --headless "+CocUpdateSync" +qa || warn "the coc update reported an error"
    fi
}

install_python_tools() {
    local cfg="$HOME/.config/pycodestyle"
    if ! grep -q '^\[pycodestyle\]' "$cfg" 2>/dev/null; then
        info "Writing the pycodestyle configuration"
        printf '[pycodestyle]\nmax_line_length = 120\n' >>"$cfg"
    fi
    if have pacman && ! have autopep8; then
        info "Installing autopep8"
        sudo pacman -S --needed --noconfirm autopep8 || warn "could not install autopep8"
    fi
}

check_deps() {
    info "Checking the optional dependencies"
    local missing=()

    # tool:reason
    local checks=(
        "git:required to fetch the plugins"
        "nvim:the main editor, needs 0.10+ for lazy.nvim"
        "node:required by coc.nvim"
        "rg:used by telescope live_grep and telescope-media-files"
        "fd:used by telescope find_files"
        "cmake:builds telescope-fzf-native"
        "make:builds avante.nvim"
        "cargo:builds the avante.nvim rust modules"
        "magick:used by image.nvim (imagemagick)"
        "ctags:used by tagbar"
        "sdcv:used by vim-stardict, needs stardict dictionaries"
        "zsh:the shell configured by zshrc"
        "tmux:terminal multiplexer"
    )

    local entry tool reason
    for entry in "${checks[@]}"; do
        tool="${entry%%:*}"
        reason="${entry#*:}"
        have "$tool" || missing+=("$tool ($reason)")
    done

    if [ ${#missing[@]} -eq 0 ]; then
        step "everything is installed"
        return 0
    fi

    warn "missing tools:"
    local item
    for item in "${missing[@]}"; do
        printf '      - %s\n' "$item" >&2
    done
    if have pacman; then
        warn "on arch: sudo pacman -S git neovim nodejs ripgrep fd cmake base-devel rust ctags imagemagick sdcv stardict-oald stardict-wordnet"
    fi
}

final_message() {
    info "Done"
    step "neovim now reads $DOTFILES/nvim (lazy.nvim), run :Lazy to inspect it"
    step "vim still reads ~/.vimrc (vim-plug)"
    step "open a new shell to pick up the zsh configuration"
    if [ -d "$BACKUP_DIR" ]; then
        step "the replaced files are in $BACKUP_DIR"
    fi
}

main() {
    info "Installing the dotfiles from $DOTFILES"
    create_dirs
    install_links

    if [ "$LINKS_ONLY" -eq 1 ]; then
        info "Done, only the symlinks were created"
        return 0
    fi

    install_fonts
    install_konsole
    check_deps

    if [ "$INSTALL_PLUGINS" -eq 1 ]; then
        install_antigen
        install_tpm
        install_vim_plugins
        install_nvim_plugins
    fi

    install_python_tools
    final_message
}

main

