local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

require("mason").setup()

require("mason-null-ls").setup({
    ensure_installed = {
        "stylua",
        "rome",
        "black",
        "gopls",
        "lua-language-server",
        "marksman",
        "eslint",
        "css-lsp",
        "isort",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "yaml-language-server",
        "pyright",
        "python-lsp-server",
        "cspell",
    },
    automatic_installation = true,
    handlers = {},
})
