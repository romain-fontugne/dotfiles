#!/usr/bin/env bash
# Shared helpers for the dotfiles installer. Sourced by install.sh and
# install/link.sh, so it must stay POSIX-ish and side effect free.

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)}"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
step() { printf '\033[1;32m  ->\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*" >&2; }
fail() { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; exit 1; }

# have <command> : true when the command is available
have() { command -v "$1" >/dev/null 2>&1; }

# backup <path> : move an existing file or directory into the backup dir.
# Dangling or replaceable symlinks are simply removed.
backup() {
    local target="$1"

    if [ -L "$target" ]; then
        rm -f "$target"
        return 0
    fi

    [ -e "$target" ] || return 0

    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/"
    warn "backed up $target to $BACKUP_DIR/$(basename "$target")"
}

# link <source> <destination> : idempotent symlink creation
link() {
    local src="$1" dest="$2"

    if [ ! -e "$src" ]; then
        warn "skipping $dest, missing source $src"
        return 0
    fi

    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
        return 0
    fi

    mkdir -p "$(dirname "$dest")"
    backup "$dest"
    ln -sfn "$src" "$dest"
    step "${dest/#$HOME/~} -> ${src/#$HOME/~}"
}

