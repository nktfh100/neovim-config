local vim = vim

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Theme
	-- use("sainnhe/sonokai")
	use("hardhackerlabs/theme-vim")

	use("nvim-tree/nvim-web-devicons")
	use("nvim-lua/plenary.nvim")

	-- Time tracking
	use("wakatime/vim-wakatime")

	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({})
		end,
	})

	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		requires = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	})

	-- Greeter
	use("goolord/alpha-nvim")

	-- Syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Completion
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use("FelipeLema/cmp-async-path") --  nvim-cmp source for path (async)
	use("hrsh7th/cmp-cmdline") --  nvim-cmp source for vim's cmdline
	use("hrsh7th/cmp-nvim-lua") --  nvim-cmp source for nvim lua
	use("L3MON4D3/LuaSnip") -- Snippet Engine
	use("hrsh7th/nvim-cmp")

	-- Emmet
	use({ "mattn/emmet-vim" })
	use({ "dcampos/cmp-emmet-vim" })

	-- LSP
	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"williamboman/mason.nvim",
		run = function()
			pcall(vim.cmd, "MasonUpdate")
		end,
	})
	use("williamboman/mason-lspconfig.nvim")
	use("jay-babu/mason-null-ls.nvim")

	use("neovim/nvim-lspconfig")

	use("windwp/nvim-ts-autotag")
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Easy Search
	use({
		"VonHeikemen/searchbox.nvim",
		requires = {
			{ "MunifTanjim/nui.nvim" },
		},
	})

	use("mbbill/undotree")

	-- Easily move lines
	use("fedepujol/move.nvim")

	-- Closes brackets
	use("rstacruz/vim-closer")

	-- Preview colors
	use("ap/vim-css-color")

	-- Adds indentation guides
	use("lukas-reineke/indent-blankline.nvim")

	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
