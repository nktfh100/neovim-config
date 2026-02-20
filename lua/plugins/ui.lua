local utils = require("utils")

return {
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		init = function()
			require("catppuccin").setup({
				integrations = {
					blink_cmp = true,
					gitsigns = true,
					snacks = true,
					hop = true,
					mason = true,
					noice = true,
					treesitter = true,
					lsp_trouble = true,
					which_key = true,
					barbecue = {
						dim_dirname = true,
						bold_basename = true,
						dim_context = false,
						alt_background = false,
					},
					native_lsp = {
						enabled = true,
					},
				},
			})
		end,
	},
	-- UI overhaul
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("noice").setup({
				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "lsp",
							kind = "progress",
							cond = function(message)
								local client = vim.tbl_get(message.opts, "progress", "client")
								return client == "ts_ls"
							end,
						},
						opts = { skip = true },
					},
				},
			})
		end,
	},
	-- Highlight TODO comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	-- VSCode like winbar
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "v1.2.*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
		init = function()
			require("barbecue").setup({
				theme = "catppuccin-macchiato",
			})
		end,
	},
	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		init = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},

	-- UI for diagnostics
	{
		"folke/trouble.nvim",
		opts = {
			focus = true,
			keys = {
				o = "jump",
				["<cr>"] = "jump_close",
			},
		},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
		init = function()
			utils.map({
				{ "<leader>x", group = "Trouble", icon = "" },
			})
		end,
	},
	-- Icons
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				-- needed since it will be false when loading and mini will fail
				package.loaded["nvim-web-devicons"] = {}
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	-- Highlight colors
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
			})
		end,
	},
	--  Display vim motions
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	opts = {},
	-- },
}
