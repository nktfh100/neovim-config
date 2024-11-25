local function map(...)
	return require("which-key").add(...)
end

return {
	map = map,
}

