-- Colorscheme, statusline and UI plugins

return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa") -- or "kanagawa-dragon"
      vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
    end,
  },

  { "nvim-tree/nvim-web-devicons", opts = {} },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        -- "bubbles_theme" was an undefined global in the vimrc, so lualine
        -- silently fell back to "auto"; keep that behaviour explicit
        theme = "auto",
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "Avante", "AvanteInput" },
          winbar = { "Avante", "AvanteInput" },
        },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch" },
        lualine_c = { "%=" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    },
  },

  { "MunifTanjim/nui.nvim", lazy = true },
  { "rcarriga/nvim-notify", lazy = true },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {},
  },

  -- Enhanced input UI
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  -- Modern input UI
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    opts = { input = { enabled = true } },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  { "machakann/vim-highlightedyank", event = "VeryLazy" },
}

