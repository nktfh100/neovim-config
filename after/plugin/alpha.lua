local alphaDashboard = require("alpha.themes.dashboard")
local utils = require("utils")

alphaDashboard.section.buttons.val = {
	alphaDashboard.button("f", "󰈞  Find file", utils.open_telescope("find_files")),
	alphaDashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	alphaDashboard.button("r", "󰷊  Recently used files", utils.open_telescope("oldfiles")),
	alphaDashboard.button("t", "  Find text", utils.open_telescope("live_grep")),
	alphaDashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
}

require("alpha").setup(alphaDashboard.config)
