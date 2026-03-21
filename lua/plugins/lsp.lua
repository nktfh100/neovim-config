local utils = require("utils")

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/lazydev.nvim",
		},
		keys = {
			{
				"H",
				function()
					vim.diagnostic.open_float({ border = "rounded" })
				end,
				desc = "Show diagnostics",
			},
			{
				"<C-k>",
				function()
					vim.lsp.buf.signature_help()
				end,
				desc = "Signature help",
			},
		},
		opts = {
			-- Centralized server configurations for vim.lsp.config
			servers = {
				lua_ls = {},
				nixd = {
					on_init = function(client, _)
						client.server_capabilities.semanticTokensProvider = nil
					end,
				},
				eslint = {
					settings = {
						format = false,
						codeAction = {
							disableRuleComment = { enable = false },
							showDocumentation = { enable = false },
						},
						quiet = false,
					},
				},
				cssls = {},
				html = {},
				jsonls = {},
				ts_ls = {},
				tailwindcss = {},
				prismals = {},
				emmet_language_server = {
					filetypes = {
						"css",
						"html",
						"javascript",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"typescriptreact",
					},
				},
				gopls = {},
				typos_lsp = {},
			},
		},
		config = function(_, opts)
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lsp_start_group = vim.api.nvim_create_augroup("UserLspStart", { clear = true })

			require("mason").setup({ ui = { border = "rounded" } })

			-- Avoid attaching LSP to artificial URI buffers (diff/fugitive).
			-- https://github.com/neovim/neovim/issues/33061#issuecomment-2754364821
			local function should_start_lsp(bufnr)
				local buftype = vim.bo[bufnr].buftype
				if buftype ~= "" then
					return false
				end

				local bufname = vim.api.nvim_buf_get_name(bufnr)
				if bufname == "" then
					return false
				end

				return not bufname:match("^[%w+.-]+://")
			end

			local function setup_server(server_name)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server_name] or {})

				vim.lsp.config(server_name, server_opts)

				local filetypes = vim.lsp.config[server_name].filetypes
				if not filetypes or vim.tbl_isempty(filetypes) then
					return
				end

				vim.api.nvim_create_autocmd("FileType", {
					group = lsp_start_group,
					pattern = filetypes,
					callback = function(args)
						if not should_start_lsp(args.buf) then
							return
						end

						vim.api.nvim_buf_call(args.buf, function()
							vim.lsp.start(vim.lsp.config[server_name])
						end)
					end,
					desc = string.format("Start %s for file buffers", server_name),
				})
			end

			require("mason-lspconfig").setup({
				automatic_installation = false,
				handlers = {
					function(server_name)
						setup_server(server_name)
					end,
				},
			})

			-- Nixos: Setup servers not managed by Mason
			for server, _ in pairs(opts.servers) do
				if not vim.tbl_contains(require("mason-lspconfig").get_installed_servers(), server) then
					setup_server(server)
				end
			end

			utils.map({
				{ "<leader>r", group = "refactor", icon = "" },
			})
		end,
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
	},
}
