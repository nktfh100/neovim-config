return
{
    {
    -- Syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "lua", "vim", "vimdoc", "javascript", "html", "python", "typescript", "bash", "css"
        },
        auto_install = true,
        sync_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    },
    },
    -- Show sticky context for off-screen scope
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
}