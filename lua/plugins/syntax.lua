return
{
    {
    -- Syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua", "vim", "vimdoc", "javascript", "html", "python", "typescript", "bash", "css"
            },
            auto_install = true,
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
    },
    -- Show sticky context for off-screen scope
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
    -- Syntax-aware text objects and motions
	{
		"ziontee113/syntax-tree-surfer",
		cmd = {
			"STSSwapPrevVisual",
			"STSSwapNextVisual",
			"STSSelectPrevSiblingNode",
			"STSSelectNextSiblingNode",
			"STSSelectParentNode",
			"STSSelectChildNode",
			"STSSwapOrHold",
			"STSSelectCurrentNode",
		},
		keys = function()

			--- Dot repeatable
			local function dr(op)
				return function()
					require("syntax-tree-surfer")
					vim.opt.opfunc = op
					return "g@l"
				end
			end

			-- stylua: ignore
            -- TODO
			return {
			-- 	{ "<M-Up>", dr("v:lua.STSSwapUpNormal_Dot"), desc = "Swap node upwards", expr = true },
			-- 	{ "<M-Down>", dr("v:lua.STSSwapDownNormal_Dot"), desc = "Swap node downwards", expr = true },
			-- 	{ "<M-Left>", dr("v:lua.STSSwapCurrentNodePrevNormal_Dot"), desc = "Swap with previous node", expr = true },
			-- 	{ "<M-Right>", dr("v:lua.STSSwapCurrentNodeNextNormal_Dot"), desc = "Swap with next node", expr = true },
				{ "<Cr>", function() vim.cmd("STSSelectCurrentNode") end, desc = "Select current node" },
			-- 	{
			-- 		"gO",
			-- 		function()
			-- 			require("syntax-tree-surfer").go_to_top_node_and_execute_commands(false, {
			-- 				"normal! O",
			-- 				"normal! O",
			-- 				"startinsert",
			-- 			})
			-- 		end,
			-- 		desc = "Insert above top-level node",
			-- 	},
			-- 	{
			-- 		"go",
			-- 		function()
            --             require("syntax-tree-surfer").go_to_top_node_and_execute_commands(true, {
            --                 "normal! o",
            --                 "normal! o",
            --             "startinsert",
            --         })
			-- 		end,
			-- 		desc = "Insert below top-level node",
			-- 	},
			-- 	-- FIXME: bug in which-keys, simplify when fixed
			-- 	{ "<M-Up>", "<CMD>STSSwapPrevVisual<CR>", desc = "Swap with previous node" , mode = "x" },
			-- 	{ "<M-Down>", "<CMD>STSSwapNextVisual<CR>", desc = "Swap with next node" , mode = "x" },
			-- 	{ "<M-Left>", "<CMD>STSSwapPrevVisual<CR>", desc = "Swap with previous node" , mode = "x" },
			-- 	{ "<M-Right>", "<CMD>STSSwapNextVisual<CR>", desc = "Swap with next node" , mode = "x" },
			-- 	{ "<C-Up>", "<CMD>STSSelectPrevSiblingNode<CR>", desc = "Select previous sibling" , mode = "x" },
			-- 	{ "<C-Down>", "<CMD>STSSelectNextSiblingNode<CR>", desc = "Select next sibling" , mode = "x" },
			-- 	{ "<C-Left>", "<CMD>STSSelectPrevSiblingNode<CR>", desc = "Select previous sibling" , mode = "x" },
			-- 	{ "<C-Right>", "<CMD>STSSelectNextSiblingNode<CR>", desc = "Select next sibling" , mode = "x" },
			-- 	{ "<Cr>", "<CMD>STSSelectParentNode<CR>", desc = "Select parent node" , mode = "x" },
			-- 	{ "<S-Cr>", "<CMD>STSSelectChildNode<CR>", desc = "Select child node" , mode = "x" },
			}
		end,
		config = true,
	},
}