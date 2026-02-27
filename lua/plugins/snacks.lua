local utils = require("utils")

return {
	"folke/snacks.nvim",
	cond = not vim.g.vscode,
	priority = 1000,
	lazy = false,
	init = function()
		utils.map({
			{ "<leader>n", group = "File tree", icon = "󰙅" },
			{ "gr", group = "LSP", icon = "󰠱" },
		})
	end,
	opts = {
		terminal = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				function()
					local current_locale = os.setlocale(nil, "time")
					os.setlocale("C", "time")
					local date = os.date("%A, %B %d, %Y")
					local time = os.date("%H:%M:%S")
					os.setlocale(current_locale, "time")
					return {
						text = {
							{ "󰃭 ", hl = "SnacksDashboardIcon" },
							{ date, hl = "SnacksDashboardDesc" },
							{ "  󱑒 ", hl = "SnacksDashboardIcon" },
							{ time, hl = "SnacksDashboardDesc" },
						},
						align = "center",
						padding = 1,
					}
				end,
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
			preset = {
				keys = {
					{
						icon = "󰸨 ",
						key = "s",
						desc = "Load last session",
						action = ":lua require('persistence').load()",
					},
					{ icon = "󰈞 ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
					{ icon = "󰈔 ", key = "e", desc = "New file", action = ":ene | startinsert" },
					{ icon = "󰷊 ", key = "r", desc = "Recently used files", action = ":lua Snacks.picker.recent()" },
					{ icon = "󰈭 ", key = "t", desc = "Find text", action = ":lua Snacks.picker.grep()" },
					{ icon = "󰗼 ", key = "q", desc = "Quit Neovim", action = ":qa" },
				},
			},
		},
		explorer = { enabled = true },
		image = { enabled = true },
		notifier = {
			enabled = true,
			-- Suppress weird "No information available" LSP hover notification
			filter = function(notif)
				return notif.msg ~= "No information available"
			end,
		},
		picker = { enabled = true },
		indent = { enabled = true },
		words = { enabled = true },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Update dashboard clock periodically
		vim.api.nvim_create_autocmd("User", {
			pattern = "SnacksDashboardOpened",
			callback = function(ev)
				local timer = vim.uv.new_timer()
				timer:start(1000, 1000, vim.schedule_wrap(function()
					if vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == "snacks_dashboard" then
						require("snacks").dashboard.update()
					else
						timer:stop()
						timer:close()
					end
				end))
			end,
		})
	end,
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

		-- LSP Navigation (uses native neovim 0.11+ keys with snacks pickers)
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Go to definition",
		},
		{
			"grr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "Go to references",
		},
		{
			"gri",
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
			"grt",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Go to type definition",
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
