-- Fuzzy finders

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "ibhagwan/fzf-lua", cmd = "FzfLua" },

  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    -- The mappings must be declared here with their right-hand side. lazy.nvim
    -- deletes the keys it manages once the plugin loads, and only restores them
    -- when the spec carries an rhs. Declaring bare lhs strings here while
    -- defining the real mappings in config/keymaps.lua makes lazy.nvim delete
    -- those user mappings on first use, so the shortcuts only fire once.
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope: find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope: live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope: buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope: help tags" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release"
          .. " && cmake --build build --config Release"
          .. " && cmake --install build --prefix build",
      },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          media_files = {
            -- filetypes whitelist, defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "png", "webp", "jpg", "jpeg" },
            -- find command, defaults to fd
            find_cmd = "rg",
          },
        },
      })
      require("telescope").load_extension("media_files")
    end,
  },
}

