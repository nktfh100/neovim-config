local utils = require("utils")

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		keys = {
			-- { "K", require("noice.lsp").hover, desc = "Show documentation" },
			{
				"H",
				function()
					vim.diagnostic.open_float({ border = "rounded" })
				end,
				desc = "Show diagnostics",
			},
			{ "<C-k>", vim.lsp.buf.signature_help, desc = "Interactive signature help" },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Interactive rename" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "gr", vim.lsp.buf.references, desc = "Go to references" },
			{ "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
			{ "gI", "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>", desc = "Go To implementation In New Tab" },
			{ "ge", vim.lsp.buf.declaration, desc = "Go to declaration" },
		},
		opts = {
			-- Disable automatic installation of servers
			servers = {
				lua_ls = {
					mason = false,
				},
				nixd = {
					mason = false,
				},
				ts_ls = {
					mason = false,
				},
				tailwindcss = {
					mason = false,
				},
				emmet_language = {
					mason = false,
				},
				prismals = {
					mason = false,
				},
			},
		},

		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("mason").setup({ ui = { border = "rounded" } })
			require("mason-lspconfig").setup({
				automatic_installation = false,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.nixd.setup({
				on_init = function(client, _)
					-- Turn off semantic tokens until they're more consistent
					client.server_capabilities.semanticTokensProvider = nil
				end,
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			lspconfig.prismals.setup({
				capabilities = capabilities,
			})
			lspconfig.emmet_language_server.setup({
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
				capabilities = capabilities,
			})

			utils.map({
				{ "<leader>r", group = "refactor", icon = "" },
			})

			-- Setup nvim-cmp for completion
			local cmp = require("cmp")
			-- local cmp_select = { behavior = cmp.SelectBehavior.Select }

			-- this is the function that loads the extra snippets to luasnip
			-- from rafamadriz/friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
					{ name = "cmdline", keyword_length = 3 },
				},
				mapping = cmp.mapping.preset.insert({
					-- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					-- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol",
						maxwidth = {
							menu = 50,
							abbr = 50,
						},
						ellipsis_char = "...",
						show_labelDetails = true,
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
			})
		end,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		"kamykn/spelunker.vim",
		config = function() end,
	},
	-- {
	-- 	"rachartier/tiny-code-action.nvim",
	-- 	dependencies = {
	-- 		{ "nvim-lua/plenary.nvim" },
	-- 		{ "nvim-telescope/telescope.nvim" },
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>a",
	-- 			function() require("tiny-code-action").code_action() end,
	-- 			desc = "Interactive list of code actions",
	-- 		},
	-- 	},
	-- 	event = "LspAttach",
	-- 	opts = {
	-- 		backend = "vim", -- FIXME: delta is not rendering correctly
	-- 		backend_opts = {
	-- 			delta = {
	-- 				header_lines_to_remove = 4,
	-- 				args = { "--features", "nosidebyside" },
	-- 			},
	-- 		},
	-- 	},
	-- }
}
