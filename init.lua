require("settings")
require("plugins")
require("mappings")

-- Set theme
vim.cmd("syntax enable")
vim.cmd("syntax on")
vim.o.t_Co = 256
vim.g.hardhacker_darker = 1
vim.cmd("colorscheme hardhacker")
