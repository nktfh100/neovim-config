local opt = vim.opt
local g = vim.g

vim.opt.termguicolors = true

-- Disable netrw (default file explorer) and its plugins
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Set file encoding to UTF-8
opt.encoding = "utf-8"

-- Enable line numbers
opt.nu = true

-- Make line numbers relative, showing line distance from the cursor position
opt.relativenumber = true

-- Use the system clipboard
opt.clipboard = "unnamedplus"

opt.tabstop = 2 -- Set width of a tab character
opt.softtabstop = 4 -- Set width of a soft tabstop (number of spaces used when pressing Tab)
opt.shiftwidth = 2 -- Set width of an auto-indent
opt.expandtab = false -- Use tabs instead of spaces

opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Case-sensitive search if uppercase is used
opt.incsearch = true -- Show matches as you type

-- Enable smart indentation based on file type and context
opt.smartindent = true

-- Disable line wrapping
opt.wrap = false

-- Enable persistent undo, allowing undo history to be saved between sessions
opt.undofile = true

-- Disable search highlighting after searching
opt.hlsearch = false

-- Set scroll offset so at least 8 lines remain visible around the cursor when scrolling
opt.scrolloff = 8

-- Always show the sign column, which is used for symbols like breakpoints or Git diff markers
opt.signcolumn = "yes"

-- Append '@-@' to the list of filename characters (used to allow '@' in filenames)
opt.isfname:append("@-@")

-- Set the time in milliseconds to wait before triggering the CursorHold event (useful for plugin responsiveness)
opt.updatetime = 50

-- Ask for confirmation to save unsaved changes before exiting
opt.confirm = true

-- Automatically save changes to file before certain actions (like switching buffers)
opt.autowrite = true

-- Enable highlighting of the current line
opt.cursorline = true

-- Open new horizontal splits below the current window
opt.splitbelow = true

-- Open new vertical splits to the right of the current window
opt.splitright = true

opt.spell = false
