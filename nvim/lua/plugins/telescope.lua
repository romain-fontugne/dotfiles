-- Fuzzy finders

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true },
  { "ibhagwan/fzf-lua", cmd = "FzfLua" },

  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    keys = { "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fh" },
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

