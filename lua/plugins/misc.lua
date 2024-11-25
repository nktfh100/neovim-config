local map = require("utils").map

return {
	{
		"folke/which-key.nvim",
		dependencies = {
			"echasnovski/mini.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			preset = "helix",
		},
		keys = {
			{
				"<leader>h",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- Jump to any character
	{
		"smoka7/hop.nvim",
		version = "v2.7.*",
		lazy = false,
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
		keys = {
			{
				"f",
				function()
					require("hop").hint_char1()
				end,
				desc = "Hop",
			},
			{
				"t",
				function()
					require("hop").hop_pattern()
				end,
				desc = "Hop Pattern Matching",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- Move lines and blocks
	{
		"fedepujol/move.nvim",
		opts = {
			char = {
				enable = true,
			},
		},
	},
	{
		"Wansmer/treesj",
		keys = { {
			"<space>rm",
			function()
				require("treesj").toggle()
			end,
			desc = "Toggle Spread",
		} },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({})
		end,
	},
	-- Easy commenting
	{
		"numToStr/Comment.nvim",
		opts = {
			mappings = {
				basic = true,
				extra = false,
			},
		},
	},
	-- Auto close buffers
	{
		"chrisgrieser/nvim-early-retirement",
		event = "VeryLazy",
		opts = { retirementAgeMins = 15 },
	},
	-- Search and replace
	{
		"VonHeikemen/searchbox.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		keys = {
			{
				"<leader>fr",
				function()
					require("searchbox").replace()
				end,
				desc = "Search And Replace",
			},
		},
		init = function()
			map({ "<leader>s", group = "Search", icon = "" })
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	-- Scoped buffers
	{ "tiagovla/scope.nvim" },
	-- Surround text objects
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "<leader>sa", -- Add surrounding in Normal and Visual modes
					delete = "<leader>sd", -- Delete surrounding
					find = "<leader>sf", -- Find surrounding (to the right)
					find_left = "<leader>sF", -- Find surrounding (to the left)
					highlight = "", -- Highlight surrounding
					replace = "<leader>sr", -- Replace surrounding
					update_n_lines = "", -- Update `n_lines`

					suffix_last = "", -- Suffix to search with "prev" method
					suffix_next = "", -- Suffix to search with "next" method
				},
			})

			map({ "<leader>s", group = "Surround", icon = "" })
		end,
	},
	-- Gitignore generator
	{
		"wintermute-cell/gitignore.nvim",
		config = function()
			require("gitignore")
		end,
		keys = {
			{
				"<leader>gi",
				function()
					require("gitignore").generate()
				end,
				desc = "Generate Gitignore",
			},
		},
	},
	{
		"atiladefreitas/lazyclip",
		config = function()
			require("lazyclip").setup()
		end,
		keys = {
			{
				"<leader>p",
				function()
					require("lazyclip").show_clipboard()
				end,
				desc = "Open Clipboard Manager",
			},
		},
	},
	{
		"junegunn/vim-peekaboo",
	},
	-- Time tracking
	{ "wakatime/vim-wakatime", lazy = false },
}
