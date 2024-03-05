-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- map control+x to delete current buffer
vim.api.nvim_set_keymap("n", "<C-x>", ":bd<CR>", { noremap = true, silent = true })

-- normal mode tab to switch buffers
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
-- normal mode shift+tab to switch buffers
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- unbind <M-j> <M-k>
vim.api.nvim_set_keymap("n", "<M-j>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-k>", "<Nop>", { noremap = true, silent = true })

-- bind <leader>m to Zenmode
vim.api.nvim_set_keymap("n", "<leader>m", ":ZenMode<CR>", { noremap = true, silent = true })
