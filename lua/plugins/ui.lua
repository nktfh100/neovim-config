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
					cmp = true,
					gitsigns = true,
					notify = true,
					alpha = true,
					hop = true,
					mason = true,
					neotree = true,
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
		lazy = false,
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
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
	-- Greeter
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local alphaDashboard = require("alpha.themes.dashboard")

			alpha.setup(require("alpha.themes.dashboard").config)

			alphaDashboard.section.header.val = {
				[[                                                    ]],
				[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
				[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
				[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
				[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
				[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
				[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
				[[                                                    ]],
			}

			alphaDashboard.section.buttons.val = {
				alphaDashboard.button("s", "󰸨  Load last session", require("persistence").load),
				alphaDashboard.button("f", "󰈞  Find file", require("telescope.builtin").find_files),
				alphaDashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
				alphaDashboard.button("r", "󰷊  Recently used files", require("telescope.builtin").oldfiles),
				alphaDashboard.button("t", "  Find text", require("telescope.builtin").live_grep),
				alphaDashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
			}

			require("alpha").setup(alphaDashboard.config)
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
		lazy = false,
		init = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},
	-- Indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	-- Transparent background
	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			require("transparent").setup({
				groups = {
					"Normal",
					"NormalNC",
					"Comment",
					"Constant",
					"Special",
					"Identifier",
					"Statement",
					"PreProc",
					"Type",
					"Underlined",
					"Todo",
					"String",
					"Function",
					"Conditional",
					"Repeat",
					"Operator",
					"Structure",
					"LineNr",
					"NonText",
					"SignColumn",
					"CursorLineNr",
					"EndOfBuffer",
				},
			})
		end,
	},
	-- Highlight symbols under cursor
	{
		"RRethy/vim-illuminate",
		event = "BufRead",
	},
	-- Highlight on yank
	{
		"machakann/vim-highlightedyank",
		event = "TextYankPost",
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
				{ "<leader>x", group = "Trouble", icon = "" },
			})
		end,
	},
	-- View definitions, references, and implementations
	{
		"dnlhc/glance.nvim",
		lazy = false,
		config = function()
			require("glance").setup({})
		end,
		init = function()
			utils.map({
				{ "<leader>d", group = "Glance", icon = "" },
			})
		end,
		keys = {
			{ "<leader>dd", "<CMD>Glance definitions<CR>", desc = "Glance definitions" },
			{ "<leader>dr", "<CMD>Glance references<CR>", desc = "Glance references" },
			{ "<leader>di", "<CMD>Glance implementations<CR>", desc = "Glance implementations" },
			{ "<leader>dt", "<CMD>Glance type_definitions<CR>", desc = "Glance type definitions" },
		},
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
}
