local map = vim.keymap.set
local g = vim.g

local function opts(desc)
    return { desc = desc, noremap = true, silent = true, nowait = true }
end

g.mapleader = " " -- map leader to space

map("i", "<C-s>", "<ESC> :update <CR>", opts("Exit Insert Mode And Save File"))
map("n", "<C-s>", ":update<CR>", opts("Save File"))

map("n", "x", '"_x', opts("Delete Char Without Yanking"))

-- Move lines and blocks per move plugin
map("n", "<A-j>", ":MoveLine(1)<CR>", opts("Move Line Down"))
map("v", "<A-j>", ":MoveBlock(1)<CR>", opts("Move Block Down"))

map("n", "<A-k>", ":MoveLine(-1)<CR>", opts("Move Line Up"))
map("v", "<A-k>", ":MoveBlock(-1)<CR>", opts("Move Block Up"))

map("n", "<A-l>", ":MoveHChar(1)<CR>", opts("Move Line Right"))
map("v", "<A-l>", ":MoveHBlock(1)<CR>", opts("Move Block Right"))

map("n", "<A-h>", ":MoveHChar(-1)<CR>", opts("Move Line Left"))
map("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts("Move Block Left"))

map("n", "<leader>a", ":NvimTreeToggle<CR>", opts("Toggle Nvim Tree"))

map("n", "<leader>t", ":terminal<CR>", opts("Terminal"))

-- Move between splits
map("n", "<leader>h", "<C-w>h", opts("Move To The Left Window"))
map("n", "<leader>j", "<C-w>j", opts("Move To The Bottom Window"))
map("n", "<leader>k", "<C-w>k", opts("Move To The Top Window"))
map("n", "<leader>l", "<C-w>l", opts("Move To The Right Window"))

-- Copy / Paste
map("v", "p", '"_dP', opts("Paste Without Yanking"))         -- Paste over currently selected text without yanking it
map("n", "<leader>p", ":pu<CR>", opts("Paste In Next Line")) -- paste line below current text

-- Telescope (Search)
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, opts("Telescope Find Files"))
map("n", "<leader>fg", builtin.live_grep, opts("Telescope Grep"))
map("n", "<leader>fb", builtin.buffers, opts("Telescope Buffers"))
map("n", "<leader>fh", builtin.help_tags, opts("Telescope Help"))
map("n", "<leader>fe", builtin.current_buffer_fuzzy_find, opts("Telescope Fuzzy Find In Current Buffer"))

-- Hop
map("n", "f", ':lua require("hop").hint_char1()<CR>', opts("Hop"))
map("n", "t", ":HopPattern<CR>", opts("Hop Pattern Matching"))

-- Open undo tree
map("n", "<leader>u", ":UndotreeToggle<CR>", opts("Undo tree"))

local function onAttach(bufnr)
    local api = require("nvim-tree.api")

    local function opts_(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- BEGIN_DEFAULT_ON_ATTACH
    -- vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
    -- vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
    -- vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
    -- vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
    -- vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
    -- vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
    -- vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
    -- vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
    -- vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
    -- vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
    -- vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
    -- vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
    -- vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
    -- vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
    -- vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
    -- vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
    -- vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
    -- vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
    -- vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
    -- vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
    -- vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
    -- vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
    -- vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
    -- vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
    -- vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
    -- vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
    -- vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
    -- vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
    -- vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
    -- vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
    -- vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    -- END_DEFAULT_ON_ATTACH

    -- Function to open file and close nvim tree
    local function open_or_edit(edit_type)
        return function()
            local node = api.tree.get_node_under_cursor()

            local open_func
            if edit_type == "normal" then
                open_func = api.node.open.edit
            elseif edit_type == "vertical" then
                open_func = api.node.open.vertical
            elseif edit_type == "horizontal" then
                open_func = api.node.open.horizontal
            elseif edit_type == "tab" then
                open_func = api.node.open.tab
            end

            if node.nodes ~= nil then
                open_func() -- expand or collapse folder
            else
                open_func()
                api.tree.close()
            end
        end
    end

    map("n", "l", open_or_edit("normal"), opts_("Edit Or Open"))
    map("n", "<C-t>", open_or_edit("tab"), opts_("Open: New Tab"))
    map("n", "<C-v>", open_or_edit("vertical"), opts_("Open: Vertical Split"))
    map("n", "<C-x>", open_or_edit("horizontal"), opts_("Open: Horizontal Split"))

    map("n", "<Tab>", api.node.open.preview, opts_("Open Preview"))
    map("n", "C", api.tree.change_root_to_node, opts_("CD"))
    map("n", "<C-k>", api.node.show_info_popup, opts_("Info"))
    map("n", "H", api.tree.collapse_all, opts_("Collapse All"))
    map("n", "A", api.tree.expand_all, opts_("Expand All"))
    map("n", "y", api.fs.copy.filename, opts_("Copy File Name"))
    map("n", "Y", api.fs.copy.relative_path, opts_("Copy Relative Path"))
    map("n", "<C-y>", api.fs.copy.absolute_path, opts_("Copy Absolute Path"))
    map("n", "-", api.tree.change_root_to_parent, opts_("Up"))
    map("n", "s", api.node.run.system, opts_("Open System"))
    map("n", "a", api.fs.create, opts_("New File"))
    map("n", "r", api.fs.rename, opts_("Rename File"))
    map("n", "d", api.fs.trash, opts_("Trash File"))
    map("n", "D", api.fs.remove, opts_("Delete File"))
    map("n", "c", api.fs.copy.node, opts_("Copy File"))
    map("n", "x", api.fs.cut, opts_("Cut File"))
    map("n", "p", api.fs.paste, opts_("Paste File"))
    map("n", "f", api.live_filter.start, opts_("Filter Files"))
    map("n", "F", api.live_filter.clear, opts_("Clear Filter"))
    map("n", "R", api.tree.reload, opts_("Refresh"))
    map("n", "S", api.tree.search_node, opts_("Search"))
    map("n", "H", api.tree.toggle_hidden_filter, opts_("Toggle Dotfiles"))
    map("n", "I", api.tree.toggle_gitignore_filter, opts_("Toggle Git Ignore"))
end

require("nvim-tree").setup({ on_attach = onAttach })

-- Trouble
map("n", "<leader>xx", ":TroubleToggle<CR>", opts("Trouble Toggle"))
map("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts("Trouble Workspace Diagnostics"))
map("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts("Trouble Document Diagnostics"))
map("n", "<leader>xl", ":TroubleToggle loclist<CR>", opts("Trouble Loclist"))
map("n", "<leader>xq", ":TroubleToggle quickfix<CR>", opts("Trouble Quick Fix"))
map("n", "gR", ":TroubleToggle lsp_references<CR>", opts("Trouble LSP References"))

-- Search box
map("n", "<leader>ss", ":SearchBoxMatchAll<CR>", opts("Search: Match All"))
map("n", "<leader>sr", ":SearchBoxReplace<CR>", opts("Search: Replace"))
map("n", "<leader>se", ":SearchBoxIncSearch<CR>", opts("Search: Incremental"))

-- Completions
require("cmp").setup({
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
})

-- Format file
map("n", "gq", vim.lsp.buf.format, opts("Format File"))
