local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"jsonls",
	"cssls",
	"dockerls",
	"docker_compose_language_service",
	"gopls",
	"html",
	"lua_ls",
	"marksman",
	"pyright",
	"sqlls",
	"yamlls",
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.code_actions.xo,
		null_ls.builtins.completion.spell,
	},
})
