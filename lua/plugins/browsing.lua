local map = require("utils").map

return {
	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"johmsalas/text-case.nvim",
		},
		cmd = "Telescope",
		lazy = true,
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({ path_display = { "truncate" } })
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({ path_display = { "truncate" } })
				end,
				desc = "Live grep",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Grep current buffer",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffer",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help",
			},
			{
				"<leader>fe",
				function()
					require("telescope.builtin").symbols()
				end,
				desc = "Select symbol",
			},
			{
				"<leader>fs",
				function()
					vim.cmd('noau normal! "vy"')
					local text = vim.fn.getreg("v")
					vim.fn.setreg("v", {})
					require("telescope.builtin").grep_string({ search = text })
				end,
				desc = "Grep current selection",
				mode = { "x", "v" },
			},
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = { flip_columns = 200 },
					},
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
							-- ["<C-T>"] = function()
							-- 	require("trouble.sources.telescope").open()
							-- end,
						},
						-- n = {
						-- 	["<C-T>"] = function()
						-- 		require("trouble.sources.telescope").open()
						-- 	end,
						-- },
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("notify")
			telescope.load_extension("media_files")
			telescope.load_extension("textcase")
			-- telescope.load_extension("yank_history")
		end,
	},
	-- File tree browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>nn", ":Neotree toggle reveal_force_cwd<cr>", desc = "Toggle file browser" },
			{ "<leader>ng", ":Neotree toggle git_status<cr>", desc = "Show git status" },
			{ "<leader>nb", ":Neotree toggle buffers<cr>", desc = "Show open buffers" },
		},
		init = function()
			map({ "<leader>n", group = "File tree", icon = "" })
		end,
		opts = {},
	},
	-- Run and visualize code actions with Telescope.
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		config = function()
			require("tiny-code-action").setup()
		end,
		keys = {
			{
				"<leader>a",
				function()
					require("tiny-code-action").code_action()
				end,
				desc = "Code actions",
			},
		},
	},
}
