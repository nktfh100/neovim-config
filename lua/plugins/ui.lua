local utils = require("utils")

if vim.g.vscode then
	return {}
end

return {
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		init = function()
			require("catppuccin").setup({
				transparent_background = true,
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
		config = function()
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
	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			local neoscroll = require("neoscroll")

			-- Helper to check if macro is being recorded
			local function is_recording()
				return vim.fn.reg_recording() ~= ""
			end

			-- Helper to execute native scroll command
			local function native_scroll(key)
				local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
				vim.api.nvim_feedkeys(keys, "n", false)
			end

			neoscroll.setup({
				mappings = {}, -- Disable default mappings
				hide_cursor = true,
				stop_eof = true,
				respect_scrolloff = false,
				cursor_scrolls_alone = true,
				duration_multiplier = 1.0,
				easing = "quadratic",
			})

			-- Custom mappings that disable scrolling during macro recording
			local keymap = {
				["<C-u>"] = function()
					if is_recording() then
						native_scroll("<C-u>")
					else
						neoscroll.ctrl_u({ duration = 250 })
					end
				end,
				["<C-d>"] = function()
					if is_recording() then
						native_scroll("<C-d>")
					else
						neoscroll.ctrl_d({ duration = 250 })
					end
				end,
				["<C-b>"] = function()
					if is_recording() then
						native_scroll("<C-b>")
					else
						neoscroll.ctrl_b({ duration = 450 })
					end
				end,
				["<C-f>"] = function()
					if is_recording() then
						native_scroll("<C-f>")
					else
						neoscroll.ctrl_f({ duration = 450 })
					end
				end,
				["<C-y>"] = function()
					if is_recording() then
						native_scroll("<C-y>")
					else
						neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
					end
				end,
				["<C-e>"] = function()
					if is_recording() then
						native_scroll("<C-e>")
					else
						neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
					end
				end,
				["zt"] = function()
					if is_recording() then
						native_scroll("zt")
					else
						neoscroll.zt({ half_win_duration = 250 })
					end
				end,
				["zz"] = function()
					if is_recording() then
						native_scroll("zz")
					else
						neoscroll.zz({ half_win_duration = 250 })
					end
				end,
				["zb"] = function()
					if is_recording() then
						native_scroll("zb")
					else
						neoscroll.zb({ half_win_duration = 250 })
					end
				end,
			}

			local modes = { "n", "v", "x" }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end,
	},
	--  Display vim motions
	-- {
	-- 	"tris203/precognition.nvim",
	-- 	opts = {},
	-- },
}
