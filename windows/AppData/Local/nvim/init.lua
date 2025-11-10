-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
opts = {
  rocks = {
    enabled = false,
    hererocks = false,
  },
}

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Indentation: 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Vertical line at column 80
vim.opt.colorcolumn = "80"
