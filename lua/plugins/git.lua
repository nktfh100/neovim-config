local map = require("utils").map

return {
	-- Diff viewer and merge tool
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Open file history" },
		},
		opts = {
			-- enhanced_diff_hl = true,
			-- view = {
			-- 	default = { layout = "diff2_horizontal" },
			-- 	merge_tool = {
			-- 		layout = "diff4_mixed",
			-- 		disable_diagnostics = true,
			-- 	},
			-- },
		},
	},
	-- Git commands
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		keys = {
			{ "<leader>g?", "<cmd>Git<cr>", desc = "Git" },
			{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
			{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
			{ "<leader>gd", "<cmd>Git diff<cr>", desc = "Git diff" },
			{ "<leader>gl", "<cmd>Git log<cr>", desc = "Git log" },
			{ "<leader>gs", "<cmd>Git status<cr>", desc = "Git status" },
		},
		init = function()
			map({ "<leader>g", group = "git", icon = "" })
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{
				"<leader>go",
				desc = "Open git repo in browser",
				function()
					require("gitlinker").get_repo_url({
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
			},
			{
				"<leader>gy",
				desc = "Open git file in browser",
				function()
					require("gitlinker").get_buf_range_url("n", {
						action_callback = require("gitlinker.actions").open_in_browser,
					})
				end,
			},
		},
	},
}
