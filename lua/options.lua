require "nvchad.options"

-- add yours here!
vim.o.cursorline = true
vim.o.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "100"
vim.opt.fileencoding = "utf-8"

-- UFO
vim.opt.foldlevel = 1
vim.opt.foldnestmax = 1
vim.opt.foldlevelstart = 99
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- cmp
vim.opt.pumheight = 8

vim.opt.swapfile = false
vim.opt.mouse = nil
