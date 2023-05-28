local M = {}

local utils = require("utils")

local map = vim.keymap.set

local opts = utils.opts

vim.g.mapleader = " " -- map leader to space

map("i", "<C-s>", "<ESC> :update <CR>", opts("Exit Insert Mode And Save File"))
map("n", "<C-s>", ":update<CR>", opts("Save File"))

map("n", "x", '"_x', opts("Delete Char Without Yanking"))

map("n", "gq", ":lua vim.lsp.buf.format()<CR>", opts("Format File"))

map("n", "<leader>b", ":bp<CR>", opts("Previous Buffer"))

map("n", "<leader>w", ":w<CR>", opts("Write Buffer"))

map("n", "<leader>q", ":q<CR>", opts("Quit Buffer"))

map("n", "<leader><leader>", ":b#<CR>", opts("Toggle Between Current And Last Buffer"))

map("n", "<leader>t", ":terminal<CR>", opts("Terminal"))

map("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", opts("Rename"))

-- Move lines and blocks
map("n", "<A-j>", ":MoveLine(1)<CR>", opts("Move Line Down"))
map("v", "<A-j>", ":MoveBlock(1)<CR>", opts("Move Block Down"))

map("n", "<A-k>", ":MoveLine(-1)<CR>", opts("Move Line Up"))
map("v", "<A-k>", ":MoveBlock(-1)<CR>", opts("Move Block Up"))

map("n", "<A-l>", ":MoveHChar(1)<CR>", opts("Move Line Right"))
map("v", "<A-l>", ":MoveHBlock(1)<CR>", opts("Move Block Right"))

map("n", "<A-h>", ":MoveHChar(-1)<CR>", opts("Move Line Left"))
map("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts("Move Block Left"))

map("n", "<leader>a", ":NvimTreeToggle<CR>", opts("Toggle Nvim Tree"))

-- Move between splits
map("n", "<leader>h", "<C-w>h", opts("Move To The Left Window"))
map("n", "<leader>j", "<C-w>j", opts("Move To The Bottom Window"))
map("n", "<leader>k", "<C-w>k", opts("Move To The Top Window"))
map("n", "<leader>l", "<C-w>l", opts("Move To The Right Window"))

-- Copy / Paste
map("v", "p", '"_dP', opts("Paste Without Yanking")) -- Paste over currently selected text without yanking it
map("n", "<C-p>", ":pu<CR>", opts("Paste In Next Line"))

-- Telescope (Search)
map("n", "<leader>ff", utils.open_telescope("find_files"), opts("Telescope Find Files"))
map("n", "<leader>fg", utils.open_telescope("live_grep"), opts("Telescope Grep"))
map("n", "<leader>fb", utils.open_telescope("buffers"), opts("Telescope Buffers"))
map("n", "<leader>fh", utils.open_telescope("help_tags"), opts("Telescope Help"))
map(
	"n",
	"<leader>fe",
	utils.open_telescope("current_buffer_fuzzy_find"),
	opts("Telescope Fuzzy Find In Current Buffer")
)

-- Hop
map("n", "f", ':lua require("hop").hint_char1()<CR>', opts("Hop"))
map("n", "t", ":HopPattern<CR>", opts("Hop Pattern Matching"))

-- Open undo tree
map("n", "<leader>u", ":UndotreeToggle<CR>", opts("Undo tree"))

-- Trouble
map("n", "<leader>xx", ":TroubleToggle<CR>", opts("Trouble Toggle"))
map("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts("Trouble Workspace Diagnostics"))
map("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts("Trouble Document Diagnostics"))
map("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts("Trouble Loclist"))
map("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts("Trouble Quick Fix"))
map("n", "gR", ":TroubleToggle lsp_references<CR>", opts("Trouble LSP References"))

-- Search box
map("n", "<leader>ss", ":SearchBoxMatchAll<CR>", opts("Search: Match All"))
map("n", "<leader>sr", ":SearchBoxReplace<CR>", opts("Search: Replace"))
map("n", "<leader>se", ":SearchBoxIncSearch<CR>", opts("Search: Incremental"))

map("n", "<S-TAB>", utils.remove_tab, opts("Remove Tab"))

-- Nvim tree
M.nvim_tree_on_attach = function(bufnr)
	local api = require("nvim-tree.api")

	local function opts_(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	map("n", "l", utils.open_or_edit(api, "normal"), opts_("Edit Or Open"))
	map("n", "<C-t>", utils.open_or_edit(api, "tab"), opts_("Open: New Tab"))
	map("n", "<C-v>", utils.open_or_edit(api, "vertical"), opts_("Open: Vertical Split"))
	map("n", "<C-x>", utils.open_or_edit(api, "horizontal"), opts_("Open: Horizontal Split"))

	map("n", "<Tab>", api.node.open.preview, opts_("Open Preview"))
	map("n", "C", api.tree.change_root_to_node, opts_("CD"))
	map("n", "<C-k>", api.node.show_info_popup, opts_("Info"))
	map("n", "H", api.tree.collapse_all, opts_("Collapse All"))
	map("n", "A", api.tree.expand_all, opts_("Expand All"))
	map("n", "y", api.fs.copy.filename, opts_("Copy File Name"))
	map("n", "Y", api.fs.copy.relative_path, opts_("Copy Relative Path"))
	map("n", "<C-y>", api.fs.copy.absolute_path, opts_("Copy Absolute Path"))
	map("n", "-", api.tree.change_root_to_parent, opts_("Up"))
	map("n", "s", api.node.run.system, opts_("Open System"))
	map("n", "a", api.fs.create, opts_("New File"))
	map("n", "r", api.fs.rename, opts_("Rename File"))
	map("n", "d", api.fs.trash, opts_("Trash File"))
	map("n", "D", api.fs.remove, opts_("Delete File"))
	map("n", "c", api.fs.copy.node, opts_("Copy File"))
	map("n", "x", api.fs.cut, opts_("Cut File"))
	map("n", "p", api.fs.paste, opts_("Paste File"))
	map("n", "f", api.live_filter.start, opts_("Filter Files"))
	map("n", "F", api.live_filter.clear, opts_("Clear Filter"))
	map("n", "R", api.tree.reload, opts_("Refresh"))
	map("n", "S", api.tree.search_node, opts_("Search"))
	map("n", "H", api.tree.toggle_hidden_filter, opts_("Toggle Dotfiles"))
	map("n", "I", api.tree.toggle_gitignore_filter, opts_("Toggle Git Ignore"))
end

-- LSP
M.lsp_on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts("Go To Declaration"))
	buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts("Go To Definition"))
	buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts("Go To Implementation"))
	buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts("LSP Hover"))
	buf_set_keymap(
		"n",
		"<leader>gd",
		":lua vim.lsp.buf.definition()<CR>:split<CR>",
		opts("Go To Definition Horizontal Split")
	)
end

return M
