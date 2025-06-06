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

local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
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
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
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
	-- {
	-- 	"ravitemer/mcphub.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	cmd = "MCPHub",
	-- 	build = "bundled_build.lua",
	-- 	config = function()
	-- 		require("mcphub").setup({
	-- 			use_bundled_binary = true,
	-- 			auto_approve = true,
	-- 			-- config = vim.fn.expand("./mcphub/servers.json"),
	-- 			extensions = {
	-- 				avante = {},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		config = function()
			require("avante").setup({
				provider = "copilot",
				cursor_applying_provider = "copilot",
				copilot = {
					__inherited_from = "copilot",
					model = "gemini-2.0-flash-001",
				},
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

				-- system_prompt = function()
				-- 	local hub = require("mcphub").get_hub_instance()
				-- 	return hub:get_active_servers_prompt()
				-- end,
				-- custom_tools = function()
				-- 	return {
				-- 		require("mcphub.extensions.avante").mcp_tool(),
				-- 	}
				-- end,
				-- disabled_tools = {
				-- 	"list_files",
				-- 	"search_files",
				-- 	"read_file",
				-- 	"create_file",
				-- 	"rename_file",
				-- 	"delete_file",
				-- 	"create_dir",
				-- 	"rename_dir",
				-- 	"delete_dir",
				-- 	"bash",
				-- },
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
				"<leader>azg",
				function()
					require("avante.api").ask({ question = avante_grammar_correction })
				end,
				desc = "Grammar Correction(ask)",
			},
			{
				"<leader>azp",
				function()
					prefill_edit_window(avante_grammar_correction)
				end,
				desc = "Grammar Correction(edit)",
				mode = { "v" },
			},
			{
				"<leader>azk",
				function()
					require("avante.api").ask({ question = avante_keywords })
				end,
				desc = "Keywords(ask)",
			},
			{
				"<leader>azy",
				function()
					prefill_edit_window(avante_keywords)
				end,
				desc = "Keywords(edit)",
				mode = { "v" },
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
				"<leader>azo",
				function()
					require("avante.api").ask({ question = avante_optimize_code })
				end,
				desc = "Optimize Code(ask)",
			},
			{
				"<leader>azO",
				function()
					prefill_edit_window(avante_optimize_code)
				end,
				desc = "Optimize Code(edit)",
				mode = { "v" },
			},
			{
				"<leader>azm",
				function()
					require("avante.api").ask({ question = avante_summarize })
				end,
				desc = "Summarize text(ask)",
			},
			{
				"<leader>azs",
				function()
					prefill_edit_window(avante_summarize)
				end,
				desc = "Summarize text(edit)",
				mode = { "v" },
			},
			{
				"<leader>azn",
				function()
					require("avante.api").ask({ question = avante_translate })
				end,
				desc = "Translate text(ask)",
			},
			{
				"<leader>azt",
				function()
					prefill_edit_window(avante_translate)
				end,
				desc = "Translate text(edit)",
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
				"<leader>azc",
				function()
					require("avante.api").ask({ question = avante_complete_code })
				end,
				desc = "Complete Code(ask)",
			},
			{
				"<leader>azi",
				function()
					prefill_edit_window(avante_complete_code)
				end,
				desc = "Complete Code(edit)",
				mode = { "v" },
			},
			{
				"<leader>azd",
				function()
					require("avante.api").ask({ question = avante_add_docstring })
				end,
				desc = "Docstring(ask)",
			},
			{
				"<leader>azD",
				function()
					prefill_edit_window(avante_add_docstring)
				end,
				desc = "Docstring(edit)",
				mode = { "v" },
			},
			{
				"<leader>azb",
				function()
					require("avante.api").ask({ question = avante_fix_bugs })
				end,
				desc = "Fix Bugs(ask)",
			},
			{
				"<leader>azf",
				function()
					prefill_edit_window(avante_fix_bugs)
				end,
				desc = "Fix Bugs(edit)",
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
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
