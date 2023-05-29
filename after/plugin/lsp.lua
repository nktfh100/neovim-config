require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"tsserver",
		"gopls",
		"jsonls",
		"cssls",
		"marksman",
		"pylsp",
		"yamlls",
	},
	automatic_installation = true,
})

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

local lspconfig = require("lspconfig")
local mappings = require("mappings")

local on_attach_save = function(client, bufnr)
	mappings.lsp_on_attach(client, bufnr)
	enable_format_on_save(client, bufnr)
end

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup({
	on_attach = on_attach_save,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

lspconfig.tsserver.setup({
	on_attach = mappings.lsp_on_attach,
	capabilities = capabilities,
})

lspconfig.pylsp.setup({
	on_attach = mappings.lsp_on_attach,
	capabilities = capabilities,
})

lspconfig.cssls.setup({
	on_attach = mappings.lsp_on_attach,
	capabilities = capabilities,
})
