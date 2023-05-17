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
    -- use 'sainnhe/sonokai'
    use("hardhackerlabs/theme-vim")

    -- Time tracking
    use("wakatime/vim-wakatime")

    use("nvim-tree/nvim-web-devicons")

    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    })

    -- Syntax highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = {
            "HiPhish/nvim-ts-rainbow2",
        },
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- File explorer
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
    })

    use({
        "folke/trouble.nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup({})
        end,
    })

    -- Fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup()
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
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup()
        end,
    })

    use({
        "antosha417/nvim-lsp-file-operations",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    })

    -- Greeter
    use({
        "goolord/alpha-nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
    })

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {
                "williamboman/mason.nvim",
                run = function()
                    pcall(vim.cmd, "MasonUpdate")
                end,
            },
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        },
    })

    use({
        "jay-babu/mason-null-ls.nvim",
        -- event = { "BufReadPre", "BufNewFile" },
        requires = {
            { "williamboman/mason.nvim" },
            { "jose-elias-alvarez/null-ls.nvim" },
        },
    })

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

    if packer_bootstrap then
        require("packer").sync()
    end
end)
