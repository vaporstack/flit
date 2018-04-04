
dofile("util.lua")

local L = {}

local library = require("library")


function L.scan()

	local entries = library.entries
	print("Scanning " .. count(entries) .. " entries for links")
end



return L