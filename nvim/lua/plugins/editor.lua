-- Editing, git, tags and debugging plugins

return {
  { "tpope/vim-surround", event = "VeryLazy" },

  -- The tabular plugin is used to format tables
  { "godlygeek/tabular", cmd = "Tabularize" },

  { "mhinz/vim-grepper", cmd = { "Grepper", "GrepperRg", "GrepperGit" } },

  { "echasnovski/mini.nvim", version = false, lazy = true },

  {
    "majutsushi/tagbar",
    -- All of these have to be listed, otherwise lazy.nvim only knows how to
    -- load the plugin from :TagbarToggle and the others fail with E492.
    cmd = {
      "TagbarToggle",
      "TagbarOpen",
      "TagbarOpenAutoClose",
      "TagbarClose",
      "TagbarShowTag",
      "TagbarCurrentTag",
      "TagbarJump",
    },
    init = function()
      vim.g.tagbar_autofocus = 1 -- autofocus on tagbar open

      -- Markdown outline support. Universal Ctags ships a Markdown parser, but
      -- tagbar still needs to know how its kinds nest to build the tree.
      -- Heading levels map to the kinds below, and Universal Ctags separates
      -- scopes with a pair of double quotes (hence sro).
      --   #      -> chapter        (c)
      --   ##     -> section        (s)
      --   ###    -> subsection     (S)
      --   ####   -> subsubsection  (t)
      --   #####  -> l4subsection   (T)
      --   ###### -> l5subsection   (u)
      local markdown = {
        ctagstype = "markdown",
        kinds = {
          "c:chapter:0:1",
          "s:section:0:1",
          "S:subsection:0:1",
          "t:subsubsection:0:1",
          "T:l4subsection:0:1",
          "u:l5subsection:0:1",
          "n:footnote:0:1",
        },
        sro = '""',
        kind2scope = {
          c = "chapter",
          s = "section",
          S = "subsection",
          t = "subsubsection",
          T = "l4subsection",
          u = "l5subsection",
        },
        scope2kind = {
          chapter = "c",
          section = "s",
          subsection = "S",
          subsubsection = "t",
          l4subsection = "T",
          l5subsection = "u",
        },
        sort = 0, -- follow the document order instead of sorting alphabetically
      }

      vim.g.tagbar_type_markdown = markdown
      -- Notes under ~/Documents/notes get the `vimwiki` filetype (see
      -- plugins/notes.lua) while still being markdown on disk, so they need the
      -- same definition under tagbar's filetype-based lookup.
      vim.g.tagbar_type_vimwiki = markdown
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

