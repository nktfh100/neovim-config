-- https://neovim.io/doc/user/tabpage.html
function CustomTabline()
	local fn = vim.fn

	local s = ""
	local total_tabs = fn.tabpagenr("$")
	local current_tab = fn.tabpagenr()

	for i = 1, total_tabs do
		local buflist = fn.tabpagebuflist(i)
		local winnr = fn.tabpagewinnr(i)
		local bufname = fn.bufname(buflist[winnr])
		local is_modified = vim.bo[buflist[winnr]].modified

		-- Highlight the current tab
		if i == current_tab then
			if is_modified then
				s = s .. "%#WarningMsg#"
			else
				s = s .. "%#TabLineSel#"
			end
		else
			if is_modified then
				s = s .. "%#WarningMsg#"
			else
				s = s .. "%#TabLine#"
			end
		end

		-- Tab number for mouse clicks
		s = s .. "%" .. i .. "T"

		-- Tab name
		if bufname ~= "" then
			local parent_dir = fn.fnamemodify(bufname, ":h:t")
			local working_dir = fn.fnamemodify(fn.getcwd(), ":t")
			bufname = fn.fnamemodify(bufname, ":t") -- File name
			if parent_dir ~= working_dir then
				-- Do not display the working directory if its in the current project root
				bufname = parent_dir .. "/" .. bufname
			end
		else
			bufname = "[No Name]"
		end

		if is_modified then
			bufname = bufname .. " [+]"
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
