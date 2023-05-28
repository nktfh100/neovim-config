local mappings = require("mappings")

require("nvim-tree").setup({ on_attach = mappings.nvim_tree_on_attach })
