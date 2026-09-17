-- Language support: coc.nvim, treesitter, vimtex, vue

return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    lazy = false,
    init = function()
      -- coc ltex
      vim.g.coc_filetype_map = { tex = "latex" }
      vim.g.coc_global_extensions = {
        "@yaegassy/coc-volar",
        "coc-pyright",
        "coc-json",
        "coc-snippets",
        "coc-explorer",
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- setup{ install_dir = ... } is the main branch API
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        -- Directory to install parsers and queries to
        -- (prepended to runtimepath to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
    end,
  },

  {
    "lervag/vimtex",
    ft = { "tex", "plaintex", "latex" },
    init = function()
      vim.g.vimtex_fold_enabled = 0
      vim.g.tex_flavor = "latex"
      vim.g.tex_conceal = "" -- don't try to be smarter than latex
    end,
  },

  { "posva/vim-vue", ft = "vue" },
}

