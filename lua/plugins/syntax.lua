return {
	{
		-- Syntax highlighting
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"html",
					"python",
					"typescript",
					"bash",
					"css",
					"tsx",
				},
				auto_install = true,
				sync_install = true,
				highlight = { enable = not vim.g.vscode },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>", -- Start selecting current node
						node_incremental = "<CR>", -- Expand to parent node
						scope_incremental = false,
						node_decremental = "<BS>", -- Shrink back to child node
					},
				},
			})
		end,
	},
	-- Show sticky context for off-screen scope
	{
		"nvim-treesitter/nvim-treesitter-context",
		cond = not vim.g.vscode,
		config = function()
			require("treesitter-context").setup({
				max_lines = 4,
				trim_scope = "inner",
			})
		end,
	},
}
