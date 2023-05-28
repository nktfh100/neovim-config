local M = {}

M.opts = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end

-- Open telescope with layout based on the window width
M.open_telescope = function(type)
	local layout = "vertical"
	if vim.fn.winwidth("%") >= 200 then
		layout = "horizontal"
	end
	return ":lua require('telescope.builtin')." .. type .. "({layout_strategy='" .. layout .. "'})<CR>"
end

-- Remove a single tab from the current line
M.remove_tab = function()
	local line = vim.api.nvim_get_current_line()

	-- Remove a tab character (\t) from the line
	local updated_line = string.gsub(line, "\t", "", 1)

	vim.api.nvim_set_current_line(updated_line)
end

-- Function to open file and close nvim tree
M.open_or_edit = function(api, edit_type)
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

return M
