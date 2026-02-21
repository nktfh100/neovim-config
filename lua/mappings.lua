local utils = require("utils")

if vim.g.vscode then
	local vscode = require("vscode-neovim")

	-- Quit / Close
	vim.keymap.set("n", "<leader>q", function()
		vscode.call("workbench.action.closeActiveEditor")
	end, { desc = "Close VSCode Tab" })

	vim.keymap.set("n", "<leader>Q", function()
		vscode.call("workbench.action.revertAndCloseActiveEditor")
	end, { desc = "Close VSCode Tab Without Saving" })

	-- Buffers (Tabs in VSCode)
	vim.keymap.set("n", "<leader>bb", function()
		vscode.call("workbench.action.nextEditor")
	end, { desc = "Next VSCode Tab" })

	vim.keymap.set("n", "<leader>bB", function()
		vscode.call("workbench.action.previousEditor")
	end, { desc = "Previous VSCode Tab" })

	vim.keymap.set("n", "<leader><leader>", function()
		vscode.call("workbench.action.openPreviousRecentlyUsedEditorInGroup")
	end, { desc = "Toggle Last VSCode Tab" })

	-- Tabs
	vim.keymap.set("n", "<leader>tn", function()
		vscode.call("workbench.action.files.newUntitledFile")
	end, { desc = "New VSCode File" })

	-- Save
	vim.keymap.set({ "n", "i" }, "<C-s>", function()
		vscode.call("workbench.action.files.save")
	end, { desc = "Save VSCode File" })

	-- Indent
	vim.keymap.set("v", "<Tab>", function()
		vscode.call("editor.action.indentLines")
	end, { desc = "Indent Right" })
	vim.keymap.set({ "n", "v" }, "<S-Tab>", function()
		vscode.call("editor.action.outdentLines")
	end, { desc = "Indent Left" })

	-- Move Lines
	vim.keymap.set({ "n", "v" }, "<A-Up>", function()
		vscode.call("editor.action.moveLinesUpAction")
	end, { desc = "Move Selection Up" })
	vim.keymap.set({ "n", "v" }, "<A-Down>", function()
		vscode.call("editor.action.moveLinesDownAction")
	end, { desc = "Move Selection Down" })

	-- Code Telescope (Snacks picker equivalents)
	vim.keymap.set("n", "<leader>ff", function()
		vscode.call("code-telescope.fuzzy.file")
	end, { desc = "Find files (Telescope)" })

	vim.keymap.set("n", "<leader>fg", function()
		vscode.call("code-telescope.fuzzy.wsText")
	end, { desc = "Live grep (Telescope)" })

	vim.keymap.set("n", "<leader>fs", function()
		vscode.call("code-telescope.fuzzy.fileText")
	end, { desc = "Grep current buffer (Telescope)" })

	vim.keymap.set("n", "<leader>fb", function()
		vscode.call("code-telescope.fuzzy.recentFiles")
	end, { desc = "Find recently opened (Telescope)" })

	vim.keymap.set("n", "<leader>fd", function()
		vscode.call("code-telescope.fuzzy.diagnostics")
	end, { desc = "Diagnostics (Telescope)" })

	-- Git / Symbols
	vim.keymap.set("n", "<leader>gB", function()
		vscode.call("code-telescope.fuzzy.branch")
	end, { desc = "Git branches (Telescope)" })

	vim.keymap.set("n", "<leader>ss", function()
		vscode.call("code-telescope.fuzzy.documentSymbols")
	end, { desc = "Document symbols (Telescope)" })

	vim.keymap.set("n", "<leader>nn", function()
		vscode.call("workbench.action.toggleSidebarVisibility")
	end, { desc = "Toggle Sidebar Visibility" })

	vim.keymap.set("n", "<leader>sS", function()
		vscode.call("code-telescope.fuzzy.wsSymbols")
	end, { desc = "Workspace symbols (Telescope)" })
else
	utils.map({
		{ "<leader><leader>", ":b#<CR>", desc = "Toggle Between Current And Last Buffer" },
		{ "<C-s>", "<ESC> :update <CR>", desc = "Exit Insert Mode And Save File", mode = "i" },
		{ "<C-s>", ":update<CR>", desc = "Save File" },
		{ "x", '"_x', desc = "Delete Char Without Yanking" },
		{ "c", '"_c', desc = "Change Without Yanking", mode = { "n", "v" } },
		{ "<S-Tab>", "<<", desc = "Indent Left" },
		{ "<Tab>", ">gv", desc = "Indent Right", mode = "v" }, -- Indent without deselecting
		{ "<S-Tab>", "<gv", desc = "Indent Left", mode = "v" },
		{ "<leader>o", "o<Esc>", desc = "Insert Line Below" },
		{ "<S-U>", "<C-R>", desc = "Redo" },
		{ "<leader>O", "O<Esc>", desc = "Insert Line Above" },
		{ "p", '"_dP', desc = "Paste Without Yanking", mode = "v" }, -- Paste over currently selected text without yanking it
		{ "<C-p>", ":pu<CR>", desc = "Paste In Next Line" },
		{ "gF", "<C-W>gf", desc = "Go To File Under Cursor (New Tab)" },
		{ "grn", desc = "Rename" },
		{ "gra", desc = "Code actions" },
		-- Go to next error:
		{ "<leader>xl", utils.goto_error_then_hint, desc = "Go To Next Error", mode = "n" },
		{ "<leader>xL", utils.goto_prev_error_then_hint, desc = "Go To Previous Error", mode = "n" },
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
		{ "<leader>t", group = "Tabs", icon = "󰓩" },
		{ "<leader>tn", ":tabnew<CR>", desc = "New Tab" },
		{ "<leader>tc", ":tabclose<CR>", desc = "Close Tab" },
		-- Jump to tab (Barbar style)
		{ "<C-'>", function()
			local hint_letters = "asdfghjklqwertyuiopzxcvbnm"
			vim.g.tabline_show_hints = true
			vim.cmd("redrawtabline")
			local char = vim.fn.getcharstr():lower()
			local idx = hint_letters:find(char)
			if idx and idx <= vim.fn.tabpagenr("$") then
				vim.cmd("tabnext " .. idx)
			end
			vim.g.tabline_show_hints = false
			vim.cmd("redrawtabline")
		end, desc = "Jump to tab" },
		{ "<leader>tj", function()
			local hint_letters = "asdfghjklqwertyuiopzxcvbnm"
			vim.g.tabline_show_hints = true
			vim.cmd("redrawtabline")
			local char = vim.fn.getcharstr():lower()
			local idx = hint_letters:find(char)
			if idx and idx <= vim.fn.tabpagenr("$") then
				vim.cmd("tabnext " .. idx)
			end
			vim.g.tabline_show_hints = false
			vim.cmd("redrawtabline")
		end, desc = "Jump to tab" },
		-- Tab navigation
		{ "[t", ":tabprevious<CR>", desc = "Previous Tab" },
		{ "]t", ":tabnext<CR>", desc = "Next Tab" },
		-- Tab reordering
		{ "<leader>tH", ":-tabmove<CR>", desc = "Move Tab Left" },
		{ "<leader>tL", ":+tabmove<CR>", desc = "Move Tab Right" },
	})
end
