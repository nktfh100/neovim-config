local utils = require("utils")

-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
	require("avante.api").edit()
	local code_bufnr = vim.api.nvim_get_current_buf()
	local code_winid = vim.api.nvim_get_current_win()
	if code_bufnr == nil or code_winid == nil then
		return
	end
	vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
	-- Optionally set the cursor position to the end of the input
	vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
	-- Simulate Ctrl+S keypress to submit
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_explain_code = "Explain the following code"
local avante_add_tests = "Implement tests for the following code"

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "VimEnter",
		config = function()
			require("copilot").setup({
				enabled = true,
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<s-Tab>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("avante").setup({
				provider = "copilot",
				cursor_applying_provider = "copilot",
				behaviour = {
					auto_apply_diff_after_generation = false,
					enable_cursor_planning_mode = true,
					auto_suggestions = false,
				},

				mappings = {
					suggestion = {
						accept = "<S-Tab>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
			})
		end,
		init = function()
			utils.map({ "<leader>az", group = "avante: ask (templates)", icon = "󰅩", mode = "n" })
			utils.map({ "<leader>az", group = "avante: edit (templates)", icon = "󰅩", mode = "v" })
		end,
		keys = {
			{
				"<leader>ao",
				function()
					vim.cmd(":AvanteClear")
				end,
				desc = "avante: clear history",
			},
			{
				"<leader>azl",
				function()
					require("avante.api").ask({ question = avante_code_readability_analysis })
				end,
				desc = "Code Readability Analysis(ask)",
			},
			{
				"<leader>azr",
				function()
					prefill_edit_window(avante_code_readability_analysis)
				end,
				desc = "Code Readability Analysis(edit)",
				mode = { "v" },
			},
			{
				"<leader>azx",
				function()
					require("avante.api").ask({ question = avante_explain_code })
				end,
				desc = "Explain Code(ask)",
			},
			{
				"<leader>aze",
				function()
					prefill_edit_window(avante_explain_code)
				end,
				desc = "Explain Code(edit)",
				mode = { "v" },
			},
			{
				"<leader>azu",
				function()
					require("avante.api").ask({ question = avante_add_tests })
				end,
				desc = "Add Tests(ask)",
			},
			{
				"<leader>azT",
				function()
					prefill_edit_window(avante_add_tests)
				end,
				desc = "Add Tests(edit)",
				mode = { "v" },
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
}
