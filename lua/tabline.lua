-- https://neovim.io/doc/user/tabpage.html
function CustomTabline()
	local fn = vim.fn

	local s = ""
	local total_tabs = fn.tabpagenr("$")
	local current_tab = fn.tabpagenr()

	for i = 1, total_tabs do
		-- Highlight the current tab
		if i == current_tab then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		-- Tab number for mouse clicks
		s = s .. "%" .. i .. "T"

		-- Add tab label
		local buflist = fn.tabpagebuflist(i)
		local winnr = fn.tabpagewinnr(i)
		local bufname = fn.bufname(buflist[winnr])

		if bufname ~= "" then
			local parent_dir = fn.fnamemodify(bufname, ":h:t") -- Get parent folder
			bufname = parent_dir .. "/" .. fn.fnamemodify(bufname, ":t") -- Parent + file name
		else
			bufname = "[No Name]"
		end

		s = s .. " " .. bufname .. " "
	end

	-- Add filler and a close button if there are multiple tabs
	s = s .. "%#TabLineFill#%T"
	if total_tabs > 1 then
		s = s .. "%=%#TabLine#%999X close "
	end

	return s
end

vim.o.tabline = "%!v:lua.CustomTabline()"