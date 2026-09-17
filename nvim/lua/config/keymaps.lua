-- Key mappings, converted from the old vimrc

local map = vim.keymap.set

-- Toggle the copilot suggestions
map({ "n", "v", "i" }, "<M-c>", "<cmd>Copilot suggestion toggle_auto_trigger<cr>")

-- Remove the highlight of the last search
map({ "n", "v", "i" }, "<C-n>", "<cmd>nohl<cr>")

-- Quicksave command
map({ "n", "v", "i" }, "<C-s>", "<cmd>update<cr>")

-- Quickquit command
map({ "n", "v", "i" }, "<C-q>", "<cmd>quit<cr>")

-- Paste image
map({ "n", "v", "i" }, "<C-p>", "<cmd>PasteImage<cr>")

-- Move around the windows without the Ctrl+w prefix
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")
map("", "<C-h>", "<C-w>h")

-- Shortcut for fugitive
map("", "<C-g>", "<cmd>Git<cr>")

-- Insert the current date and time
map("n", "<Leader>m", 'i<C-R>=strftime("%Y-%m-%d %a")<CR><Esc>', { remap = true })
map("i", "<Leader>m", '<C-R>=strftime("%Y-%m-%d %a")<CR>', { remap = true })
map("n", "<Leader>n", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>', { remap = true })
map("i", "<Leader>n", '<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>', { remap = true })

-- Map the sort function to a key
map("v", "<Leader>s", ":sort<cr>")

-- Better indentation: keep the selection after shifting a block
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Easier formatting of paragraphs
map("v", "Q", "gq")
map("n", "Q", "gqap")

-- Buffer management
map("n", "<F5>", ":buffers<CR>:buffer<Space>")

-- Thesaurus and dictionary
map("n", "<leader>t", "<cmd>ThesaurusQueryReplaceCurrentWord<cr>")
map("n", "<leader>d", "<cmd>StarDictCursor<cr>")

-- Toggle the tagbar display
map("", "<F4>", "<cmd>TagbarToggle<cr>")

-- Escape from the nvim terminal with ESC
map("t", "<Esc>", [[<C-\><C-n>]])

-- Find files using Telescope command-line sugar
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- coc-explorer
map("n", "<space>e", "<cmd>CocCommand explorer<cr>")

-- coc.nvim: use <c-space> to trigger completion
map("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- coc.nvim: navigate diagnostics
map("n", "<leader>k", "<Plug>(coc-diagnostic-prev)", { silent = true })
map("n", "<leader>j", "<Plug>(coc-diagnostic-next)", { silent = true })

-- coc.nvim: gotos
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

-- coc.nvim: use K to show the documentation in a preview window
map("n", "K", function()
  if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  else
    vim.fn.CocActionAsync("doHover")
  end
end, { silent = true })

-- coc.nvim: rename the current word
map("n", "<leader>rn", "<Plug>(coc-rename)")

-- coc.nvim: format the selected region
map({ "n", "x" }, "<leader>f", "<Plug>(coc-format-selected)")

-- coc.nvim: codeAction of the selected region, ex: <leader>aap for the current paragraph
map({ "n", "x" }, "<leader>a", "<Plug>(coc-codeaction-selected)")

-- coc.nvim: codeAction of the current line
map("n", "<leader>ac", "<Plug>(coc-codeaction)")

-- coc.nvim: fix the autofix problem of the current line
map("n", "<leader>qf", "<Plug>(coc-fix-current)")

-- coc.nvim: function text objects, requires the document symbols
-- feature of the language server
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)")
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)")

-- Better navigating through the omnicomplete option list
-- See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
local function omni_popup(action)
  if vim.fn.pumvisible() == 1 then
    if action == "j" then
      return "<C-N>"
    elseif action == "k" then
      return "<C-P>"
    end
  end
  return action
end

map("i", "<C-j>", function()
  return omni_popup("j")
end, { silent = true, expr = true })

map("i", "<C-k>", function()
  return omni_popup("k")
end, { silent = true, expr = true })

