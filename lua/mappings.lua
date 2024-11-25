local utils = require("utils")

utils.map({
	{ "<leader><leader>", ":b#<CR>", desc = "Toggle Between Current And Last Buffer" },
	{ "<C-s>", "<ESC> :update <CR>", desc = "Exit Insert Mode And Save File", mode = "i" },
	{ "<C-s>", ":update<CR>", desc = "Save File" },
	{ "x", '"_x', desc = "Delete Char Without Yanking" },
	{ "<S-Tab>", "<<", desc = "Indent Left" },
	{ "<Tab>", ">gv", desc = "Indent Right", mode = "v" }, -- Indent without deselecting
	{ "<S-Tab>", "<gv", desc = "Indent Left", mode = "v" },
	{ "<leader>o", "o<Esc>", desc = "Insert Line Below" },
	{ "<S-U>", "<C-R>", desc = "Redo" },
	{ "<leader>O", "O<Esc>", desc = "Insert Line Above" },
	{ "p", '"_dP', desc = "Paste Without Yanking", mode = "v" }, -- Paste over currently selected text without yanking it
	{ "<C-p>", ":pu<CR>", desc = "Paste In Next Line" },
	{ "gF", "<C-W>gf", desc = "Go To File Under Cursor (New Tab)" },
	-- Move lines and blocks
	{ "<A-Up>", ":MoveLine(-1)<CR>", desc = "Move Line Up" },
	{ "<A-UP>", ":MoveBlock(-1)<CR>", desc = "Move Block Up", mode = "v" },
	{ "<A-Down>", ":MoveLine(1)<CR>", desc = "Move Line Down" },
	{ "<A-Down>", ":MoveBlock(1)<CR>", desc = "Move Block Down", mode = "v" },
	{ "<A-Right>", ":MoveHChar(1)<CR>", desc = "Move Line Right" },
	{ "<A-Right>", ":MoveHBlock(1)<CR>", desc = "Move Block Right", mode = "v" },
	{ "<A-Left>", ":MoveHChar(-1)<CR>", desc = "Move Line Left" },
	{ "<A-Left>", ":MoveHBlock(-1)<CR>", desc = "Move Block Left", mode = "v" },
	-- Buffers
	{ "<leader>q", ":q<CR>", desc = "Quit Buffer" },
	{ "<leader>Q", ":q!<CR>", desc = "Quit Buffer Without Saving" },
	{ "<leader>b", group = "Move Buffers", icon = "" },
	{ "<leader>bb", ":bn<CR>", desc = "Next Buffer" },
	{ "<leader>bB", ":bp<CR>", desc = "Previous Buffer" },
	-- Move between splits
	{ "<leader>h", "<C-w>h", desc = "Move To The Left Split" },
	{ "<leader>j", "<C-w>j", desc = "Move To The Bottom Split" },
	{ "<leader>k", "<C-w>k", desc = "Move To The Top Split" },
	{ "<leader>l", "<C-w>l", desc = "Move To The Right Split" },
	-- Tabs:
	{ "<leader>t", group = "Tabs", icon = "" },
	{ "<leader>tn", ":tabnew<CR>", desc = "New Tab" },
	{ "<leader>ta", "gT", desc = "Move Tab Left" },
	{ "<leader>td", "gt", desc = "Move Tab Right" },
})
