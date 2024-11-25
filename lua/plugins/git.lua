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
	-- Git utilities, gutter signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		keys = {
			{ "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
			{ "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, desc = 'Undo "stage hunk"' },
			{ "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
			{ "<leader>gn", function() require("gitsigns").next_hunk() end, desc = "Next hunk" },
			{ "<leader>gN", function() require("gitsigns").prev_hunk() end, desc = "Previous hunk" },
			{ "<leader>gp", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview hunk" },
		},
		init = function() map { "<leader>g", group = "git", icon = "" } end,
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
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = { mappings = nil },
		keys = {
			{
				"<leader>go",
				function()
					require("gitlinker").get_repo_url {
						action_callback = require("gitlinker.actions").open_in_browser,
					}
				end,
				desc = "Open git repo in browser",
			},
		},
	},
}