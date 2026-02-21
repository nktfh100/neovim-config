local M = {}

local stats = {
	session_start = os.date("%Y-%m-%d %H:%M:%S"),
	timeline = {},
}

local current_event = {
	key = nil,
	count = 0,
	start_pos = nil,
	line_content = nil,
}
local log_limit = 150

local function get_log_path()
	return vim.fn.stdpath("data") .. "/nvim_coach_pro.json"
end

local function flush_current_event()
	if current_event.key then
		local end_pos = vim.api.nvim_win_get_cursor(0)
		table.insert(stats.timeline, {
			key = current_event.key,
			count = current_event.count,
			start_pos = current_event.start_pos,
			end_pos = end_pos,
			-- Capture the text of the line where the action started
			context = current_event.line_content,
			time = os.date("%H:%M:%S"),
		})
		if #stats.timeline > log_limit then
			table.remove(stats.timeline, 1)
		end
	end
end

function M.setup()
	vim.on_key(function(key, typed)
		if not typed or typed == "" then
			return
		end
		local k = vim.fn.keytrans(typed):lower()

		-- Check if we are in a normal buffer (ignore popups/command line)
		local buftype = vim.bo.buftype
		if buftype ~= "" then
			return
		end

		if k == current_event.key then
			current_event.count = current_event.count + 1
		else
			flush_current_event()

			-- Start new event tracking
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line_text = vim.api.nvim_get_current_line()

			current_event.key = k
			current_event.count = 1
			current_event.start_pos = cursor
			-- Only keep 50 chars of context to save space/privacy
			current_event.line_content = line_text:sub(1, 100)
		end
	end)

	vim.api.nvim_create_user_command("CoachSave", M.save_to_file, {})
end

function M.save_to_file()
	flush_current_event()
	stats.session_end = os.date("%Y-%m-%d %H:%M:%S")

	local prompt = [[
System: You are a Neovim Expert. Analyze the timeline. 
Each entry shows (Key, Count, Start [row, col], End [row, col], Line Context).

Instructions:
1. Look at the distance between start_pos and end_pos.
2. If the user pressed 'l' 20 times to reach a semicolon, suggest 'f;'.
3. If the user used 'j' 10 times, suggest '10j' or '}'.
4. Analyze the 'context' string to see if text objects (ciw, ca", etc) were applicable.

Timeline:
]] .. vim.json.encode(stats)

	local path = get_log_path()
	local file = io.open(path, "w")
	if file then
		file:write(prompt)
		file:close()
		vim.notify("Coach: Game tape saved to " .. path)
	end
end

return M
