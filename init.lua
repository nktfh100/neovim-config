vim.g.mapleader = " "
if not vim.g.vscode then
	vim.opt.laststatus = 3
end
vim.g.maplocalleader = "\\"

require("settings")
require("lazy_init")
require("mappings")
if not vim.g.vscode then
	require("tabline")
end

-- Set theme
if not vim.g.vscode then
	vim.cmd("colorscheme catppuccin-macchiato")
end

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
