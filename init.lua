vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("settings")
require("lazy_init")
require("mappings")
require("tabline")
-- Set theme
vim.cmd("syntax enable")
vim.cmd("syntax on")
vim.cmd("colorscheme catppuccin-macchiato")
