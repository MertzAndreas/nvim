vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.autoformat = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.confirm = true

vim.o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.termguicolors = true

vim.o.undofile = true
vim.o.undolevels = 10000

vim.o.winborder = "rounded"

vim.o.scrolloff = 8
vim.o.cursorline = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"

vim.o.wrap = false
