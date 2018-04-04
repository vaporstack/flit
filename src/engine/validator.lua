

dofile("util.lua")

local test = require"test"

local V = {}
local library = require"library"

function V.check_duplicate_name_nodes()
	local entries = library.entries
	local c = count(entries)
	print("Checking " .. c .. " entries.")
	local duplicates = {}
	for key, value in pairs(entries) do
		print(key)
	end

end

test.run()

V.check_duplicate_name_nodes()


return V;