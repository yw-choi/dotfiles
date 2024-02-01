-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- map control+x to delete current buffer
vim.api.nvim_set_keymap("n", "<C-x>", ":bd<CR>", { noremap = true, silent = true })

-- normal mode tab to switch buffers
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })

-- 0 to _ in normal mode
vim.api.nvim_set_keymap("n", "0", "_", { noremap = true, silent = true })
