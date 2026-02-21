local map = require("utils").map

if vim.g.vscode then
	return {}
end

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
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns-opts`
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "―" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
				map("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })

				-- Actions
				map("n", "<leader>ga", gs.stage_hunk, { desc = "Stage Hunk" })
				map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
				map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
				map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
				map("n", "<leader>gw", gs.toggle_deleted, { desc = "Toggle Deleted" })
				map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
				map("n", "<leader>gL", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
				map("n", "<leader>gD", gs.diffthis, { desc = "Diff This" })
				map("n", "<leader>ub", function() gs.setup({ current_line_blame = true }) end, { desc = "Toggle Line Blame" })
			end,
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
