vim.g.mapleader = ","

-------------------------
-- lazy plugin manager --
-------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------
-- load plugins --
------------------
require("lazy").setup({
  'joshdick/onedark.vim',
  'itchyny/lightline.vim',
  'tpope/vim-commentary',
  'tell-k/vim-autopep8',
  { 'nvim-telescope/telescope.nvim', tag = '0.1.1', dependencies = { 'nvim-lua/plenary.nvim' } },
})

-- autopep8
vim.g["autopep8_on_save"] = 1
vim.g["autopep8_disable_show_diff"] =1

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})

-----------------
-- vim options --
-----------------
local opt = vim.opt
opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

opt.backspace = 'indent,eol,start'

opt.clipboard:append('unnamedplus')

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append('-')

-----------------
-- colorscheme --
-----------------
vim.cmd("syntax on")

vim.g["lightline"] = { colorscheme='onedark' }
vim.g["onedark_color_overrides"] = {
 background = {gui = "#000000", cterm = "00", cterm16 = "0" },
 foreground = {gui = "#FFFFFF", cterm = "15", cterm16 = "7" },
}
vim.cmd("colorscheme onedark")

------------
-- keymap --
------------
local keymap = vim.keymap
keymap.set("n", "<leader><CR>", ":nohl<CR>")
keymap.set("n", "0", "^")
keymap.set("n", "x", '"_x')


