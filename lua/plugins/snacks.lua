local utils = require("utils")

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		utils.map({
			{ "<leader>n", group = "File tree", icon = "" },
		})
	end,
	opts = {
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{
						icon = "󰸨 ",
						key = "s",
						desc = "Load last session",
						action = ":lua require('persistence').load()",
					},
					{ icon = "󰈞 ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
					{ icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
					{ icon = "󰷊 ", key = "r", desc = "Recently used files", action = ":lua Snacks.picker.recent()" },
					{ icon = " ", key = "t", desc = "Find text", action = ":lua Snacks.picker.grep()" },
					{ icon = "󰩈 ", key = "q", desc = "Quit Neovim", action = ":qa" },
				},
			},
		},
		explorer = { enabled = true },
		image = { enabled = true },
		notifier = { enabled = true },
		picker = { enabled = true },
		indent = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		-- File & Text Navigation
		{
			"<leader>p",
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lines()
			end,
			desc = "Grep current buffer",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffer",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume last search",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix list",
		},

		-- Visual Selection Grep
		{
			"<leader>fs",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep current selection",
			mode = { "x", "v" },
		},

		-- Git
		{
			"<leader>gC",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git commits",
		},
		{
			"<leader>gB",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git branches",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git status diff",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Changed files",
		},

		-- LSP Navigation (replaces native gd/gr/gi/ge)
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Go to definition",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Go to references",
		},
		{
			"gi",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Go to implementation",
		},
		{
			"ge",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Go to declaration",
		},
		{
			"gt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Go to type definition",
		},
		{
			"<leader>e",
			function()
				vim.lsp.buf.code_action()
			end,
			desc = "Code actions",
		},

		-- File Explorer
		{
			"<leader>nn",
			function()
				Snacks.explorer()
			end,
			desc = "Toggle file browser",
		},

		-- Notifications
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},
}
