---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.nvimtree = {
    n = {
        ["<leader>n"] = {"<cmd>NvimTreeToggle<CR>", "Toggle NvimTree"}
    }
}

-- more keybinds!

return M
