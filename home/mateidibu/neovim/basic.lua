-- basic vim settings/keybinds
vim.o.number = true
vim.o.relativenumber = true
vim.o.smartcase = true
vim.o.smarttab = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.mouse = ""
vim.o.hidden = true
vim.cmd("set noshowmode")

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.listchars = "tab:<->,trail:~,extends:>,precedes:<,leadmultispace:···+"
vim.o.list = true

vim.cmd("syntax off")

require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})
