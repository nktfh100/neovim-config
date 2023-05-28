local opt = vim.opt
local g = vim.g

-- disable netrw (for nvim tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.encoding = "utf-8"

opt.nu = true -- Enable line numbers
opt.relativenumber = true -- Make line number reletive

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false -- Disable line wrap

opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Persistent undo for undo tree
opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8 -- Always show 8 lines from  the screen edge
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.confirm = true -- Confirm to save changes before exiting
opt.autowrite = true -- Enable auto write
opt.cursorline = true -- Highlight the current line

opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Fix markdown indentation settings
g.markdown_recommended_style = 0
