local opt = vim.opt

-- display
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.wrap = false
opt.termguicolors = true

-- mouse
opt.mouse = "a"

-- search
opt.ignorecase = true
opt.smartcase = true

-- indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- performance
opt.updatetime = 300

-- autocompletion
opt.completeopt = "menu,menuone,noselect"

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
