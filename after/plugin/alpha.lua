local alphaDashboard = require("alpha.themes.dashboard")

alphaDashboard.section.buttons.val = {
	alphaDashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
	alphaDashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	alphaDashboard.button("r", "󰷊  Recently used files", ":Telescope oldfiles <CR>"),
	alphaDashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	alphaDashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
}

require("alpha").setup(alphaDashboard.config)
