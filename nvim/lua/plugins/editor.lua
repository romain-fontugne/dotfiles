-- Editing, git, tags and debugging plugins

return {
  { "tpope/vim-surround", event = "VeryLazy" },

  -- The tabular plugin is used to format tables
  { "godlygeek/tabular", cmd = "Tabularize" },

  { "mhinz/vim-grepper", cmd = { "Grepper", "GrepperRg", "GrepperGit" } },

  { "echasnovski/mini.nvim", version = false, lazy = true },

  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
    init = function()
      vim.g.tagbar_autofocus = 1 -- autofocus on tagbar open
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gclog" },
  },

  {
    "puremourning/vimspector",
    init = function()
      vim.g.vimspector_enable_mappings = "VISUAL_STUDIO"
    end,
  },

  {
    "ron89/thesaurus_query.vim",
    cmd = { "Thesaurus", "ThesaurusQueryReplaceCurrentWord" },
    keys = { "<leader>t" },
    init = function()
      vim.g.online_thesaurus_map_keys = 0
    end,
  },

  {
    "phongvcao/vim-stardict",
    cmd = { "StarDict", "StarDictCursor" },
    keys = { "<leader>d" },
  },
}

