-- General editor options, converted from the old vimrc

local opt = vim.opt

-- Encoding ("encoding" is always utf-8 in Neovim, only fileencoding matters)
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8"

-- Better copy and paste
opt.clipboard:append("unnamedplus")

-- Mouse and backspace
opt.mouse = "a"
opt.backspace = { "indent", "eol", "start" }

-- Speed up redraws
opt.lazyredraw = true

-- UI
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "no"
opt.termguicolors = true
opt.background = "dark"

-- Width of the document (used by gd) and visual guide
opt.textwidth = 79
opt.wrap = false
opt.formatoptions:remove("t") -- don't automatically wrap text when typing
opt.colorcolumn = "80"

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.expand("$HOME/.vim/undo")
opt.undolevels = 1000
opt.undoreload = 10000

opt.history = 700

-- Real programmers don't use TABs but spaces
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true

-- Make search case insensitive
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Buffer management
opt.hidden = true

-- Completion
opt.completeopt = { "longest", "menuone" }
opt.complete:append("kspell")

-- Live preview of substitutions
opt.inccommand = "nosplit"

-- No conceal on the cursor line
-- (the vimrc had a typo here: "set concealcursor = nc" is invalid)
opt.concealcursor = "nc"

-- Python provider
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.loaded_python_provider = 1

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

