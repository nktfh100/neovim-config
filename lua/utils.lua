local function map(mappings)
	local ok, wk = pcall(require, "which-key")
	if ok then
		return wk.add(mappings)
	end
	-- Fallback for VSCode
	for _, mapping in ipairs(mappings) do
		local lhs = mapping[1]
		local rhs = mapping[2]
		if lhs and rhs and type(lhs) == "string" and (type(rhs) == "string" or type(rhs) == "function") then
			local mode = mapping.mode or "n"
			local opts = { desc = mapping.desc }
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end
end

local function pos_equal(p1, p2)
	local r1, c1 = unpack(p1)
	local r2, c2 = unpack(p2)
	return r1 == r2 and c1 == c2
end

-- https://github.com/neovim/neovim/discussions/25588
local function goto_error_then_hint()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true })
	local pos2 = vim.api.nvim_win_get_cursor(0)
	if pos_equal(pos, pos2) then
		vim.diagnostic.goto_next({ wrap = true })
	end
end

local function goto_prev_error_then_hint()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, wrap = true })
	local pos2 = vim.api.nvim_win_get_cursor(0)
	if pos_equal(pos, pos2) then
		vim.diagnostic.goto_prev({ wrap = true })
	end
end

return {
	map = map,
	goto_error_then_hint = goto_error_then_hint,
	goto_prev_error_then_hint = goto_prev_error_then_hint,
}
