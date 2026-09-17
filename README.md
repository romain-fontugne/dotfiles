# dotfiles
My dotfiles (zsh, vim, neovim, tmux, screen, git)

## Install
```Shell
git clone https://github.com/romain-fontugne/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer is idempotent, re-run it any time to pick up new configuration.
Anything it replaces is moved to `~/.dotfiles-backup/<timestamp>/`.

```Shell
./install.sh --links-only   # only (re)create the symlinks
./install.sh --no-plugins   # skip the zsh/tmux/vim/neovim plugin downloads
./install.sh --help
```

It creates the symlinks, installs the patched fonts and the konsole
colorscheme, sets up antigen (zsh), tpm (tmux), vim-plug (vim) and
lazy.nvim (neovim), then reports the missing optional dependencies.

## Layout
| Path | Content |
| --- | --- |
| `nvim/` | Neovim configuration, lazy.nvim, linked to `~/.config/nvim` |
| `vim/` | `vimrc.symlink` for plain vim, still using vim-plug |
| `coc/` | `coc-settings.json`, linked into `~/.config/nvim` |
| `zsh/`, `tmux/`, `git/`, `screen/`, `kitty/`, `konsole/` | the matching configurations |
| `install/` | `lib.sh` helpers and `link.sh`, the symlink creation |

Neovim reads `nvim/init.lua`, which bootstraps lazy.nvim and loads
`nvim/lua/config/` (options, keymaps, autocmds) and `nvim/lua/plugins/`
(the plugin specs). Use `:Lazy` to manage the plugins.

## Other
Remove previous dotfiles and the entire vim directory!
```Shell
sh rm_files.sh
```

