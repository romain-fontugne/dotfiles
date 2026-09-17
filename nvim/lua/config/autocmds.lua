-- Autocommands and user commands, converted from the old vimrc

local augroup = vim.api.nvim_create_augroup("dotfiles", { clear = true })

-- Highlight the symbol under the cursor on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.fn.CocActionAsync("highlight")
  end,
})

-- Setup formatexpr for the specified filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "typescript", "json" },
  callback = function()
    vim.bo.formatexpr = "CocAction('formatSelected')"
  end,
})

-- Update the signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
  group = augroup,
  pattern = "CocJumpPlaceholder",
  callback = function()
    vim.fn.CocActionAsync("showSignatureHelp")
  end,
})

-- Turn on the spell check for tex files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = "*.tex",
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- No line numbers in the terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Use :Format to format the current buffer
vim.api.nvim_create_user_command("Format", function()
  vim.fn.CocAction("format")
end, { nargs = 0 })

-- Use :Fold to fold the current buffer
vim.api.nvim_create_user_command("Fold", function(o)
  vim.fn.CocAction("fold", o.args)
end, { nargs = "?" })

-- Use :OR to organize the imports of the current buffer
vim.api.nvim_create_user_command("OR", function()
  vim.fn.CocAction("runCommand", "editor.action.organizeImport")
end, { nargs = 0 })

-- Add status line support, for integration with other plugins, see :h coc-status
vim.opt.statusline:prepend([[%{coc#status()}%{get(b:,'coc_current_function','')}]])

