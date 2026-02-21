vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("settings")
require("lazy_init")
require("mappings")
require("tabline")

-- Set theme
vim.cmd("colorscheme catppuccin-macchiato")

-- hyprland:
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.hl", "*.conf" }, -- "hypr*.conf"
	callback = function(event)
		vim.lsp.start({
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		})
	end,
})
vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

require("coach").setup()
