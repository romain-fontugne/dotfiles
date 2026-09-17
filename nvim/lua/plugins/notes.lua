-- Notes, markdown rendering and images

return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        { path = "~/Documents/notes/", syntax = "markdown", ext = ".md" },
      }
      vim.g.vimwiki_global_ext = 0
      -- No conceal added by the indent line plugin
      vim.g.indentLine_setConceal = 0
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "Avante" },
    opts = {
      enabled = true,
      latex = { enabled = false },
      preset = "obsidian",
      file_types = { "markdown", "Avante" },
    },
  },

  {
    "3rd/image.nvim",
    build = false,
    opts = {
      backend = "kitty", -- or "ueberzug" or "sixel"
      processor = "magick_cli", -- or "magick_rock"
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "inline", -- or "popup"
          floating_windows = false, -- if true, images are rendered in floating markdown windows
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        asciidoc = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          only_render_image_at_cursor_mode = "popup",
          floating_windows = false,
          filetypes = { "asciidoc", "adoc" },
        },
        neorg = {
          enabled = true,
          filetypes = { "norg" },
        },
        rst = { enabled = true },
        typst = { enabled = true, filetypes = { "typst" } },
        html = { enabled = false },
        css = { enabled = false },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      scale_factor = 1.0,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = {
        "cmp_menu",
        "cmp_docs",
        "snacks_notif",
        "scrollview",
        "scrollview_sign",
      },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- needs visual-activity off
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  {
    "hakonharnes/img-clip.nvim",
    cmd = "PasteImage",
    keys = { "<C-p>" },
    opts = {},
  },
}

