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
			servers = {
				lua_ls = {},
				nixd = {},
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

			require("mason").setup({ ui = { border = "rounded" } })

			-- Disable nixd semantic tokens
			-- https://github.com/neovim/neovim/issues/33061
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "nixd" then
						client.server_capabilities.semanticTokensProvider = nil
					end
				end,
			})

			local function setup_server(server_name)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server_name] or {})

				vim.lsp.config(server_name, server_opts)
				vim.lsp.enable(server_name)
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
				{ "<leader>r", group = "refactor", icon = "" },
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
