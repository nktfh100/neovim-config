local map = require("utils").map

return {
	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"johmsalas/text-case.nvim",
		},
		cmd = "Telescope",
		lazy = true,
		keys = {
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files({ path_display = { "truncate" } })
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep({ path_display = { "truncate" } })
				end,
				desc = "Live grep",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Grep current buffer",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffer",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help",
			},
			{
				"<leader>fe",
				function()
					require("telescope.builtin").symbols()
				end,
				desc = "Select symbol",
			},
			{
				"<leader>fs",
				function()
					vim.cmd('noau normal! "vy"')
					local text = vim.fn.getreg("v")
					vim.fn.setreg("v", {})
					require("telescope.builtin").grep_string({ search = text })
				end,
				desc = "Grep current selection",
				mode = { "x", "v" },
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").resume()
				end,
				desc = "Resume last search",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>gC",
				function()
					require("telescope.builtin").git_commits()
				end,
				desc = "Git commits",
			},
			{
				"<leader>gB",
				function()
					require("telescope.builtin").git_branches()
				end,
				desc = "Git branches",
			},
			{
				"<leader>gS",
				function()
					require("telescope.builtin").git_status()
				end,
				desc = "Git status diff",
			},
			{
				"<leader>lr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>fk",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>fq",
				function()
					require("telescope.builtin").quickfix()
				end,
				desc = "Quickfix list",
			},
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = { flip_columns = 200 },
					},
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
							-- ["<C-T>"] = function()
							-- 	require("trouble.sources.telescope").open()
							-- end,
						},
						-- n = {
						-- 	["<C-T>"] = function()
						-- 		require("trouble.sources.telescope").open()
						-- 	end,
						-- },
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("notify")
			telescope.load_extension("media_files")
			telescope.load_extension("textcase")
			-- telescope.load_extension("yank_history")
		end,
	},
	-- File tree browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>nn", ":Neotree toggle reveal_force_cwd<cr>", desc = "Toggle file browser" },
			{ "<leader>ng", ":Neotree toggle git_status<cr>", desc = "Show git status" },
			{ "<leader>nb", ":Neotree toggle buffers<cr>", desc = "Show open buffers" },
		},
		init = function()
			map({ "<leader>n", group = "File tree", icon = "" })
		end,
		config = function()
			require("neo-tree").setup({
				filesystem = {
					commands = {
						avante_add_files = function(state)
							local node = state.tree:get_node()
							local filepath = node:get_id()
							local relative_path = require("avante.utils").relative_path(filepath)

							local sidebar = require("avante").get()

							local open = sidebar:is_open()
							-- ensure avante sidebar is open
							if not open then
								require("avante.api").ask()
								sidebar = require("avante").get()
							end

							sidebar.file_selector:add_selected_file(relative_path)

							-- remove neo tree buffer
							if not open then
								sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
							end
						end,
					},
					window = {
						mappings = {
							["oa"] = "avante_add_files",
						},
					},
				},
			})
		end,
		opts = {},
	},
	-- Run and visualize code actions with Telescope.
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		event = "LspAttach",
		config = function()
			require("tiny-code-action").setup()
		end,
		keys = {
			{
				"<leader>e",
				function()
					require("tiny-code-action").code_action()
				end,
				desc = "Code actions",
			},
		},
	},
	{
		"axkirillov/easypick.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local easypick = require("easypick")

			local get_default_branch = "git remote show origin | grep 'HEAD branch' | cut -d' ' -f5"
			local base_branch = vim.fn.system(get_default_branch) or "main"

			easypick.setup({
				pickers = {
					-- diff current branch with base_branch and show files that changed with respective diffs in preview
					{
						name = "changed_files",
						command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
						previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
					},

					-- list files that have conflicts with diffs in preview
					{
						name = "conflicts",
						command = "git diff --name-only --diff-filter=U --relative",
						previewer = easypick.previewers.file_diff(),
					},
				},
			})
		end,
		keys = {
			{
				"<leader>fc",
				function()
					vim.cmd("Easypick changed_files")
				end,
				desc = "Changed files",
			},
			{
				"<leader>fv",
				function()
					vim.cmd("Easypick conflicts")
				end,
				desc = "Conflicts",
			},
		},
	},
}
