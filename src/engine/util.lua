


function count(data)
	print("countin")
	local count = 0
	for index, value in pairs(data) do
		count = count + 1
	end
	return count
end

local function split(input)
	local res = {}
	local c = 0
	for i in string.gmatch(input, "%S+") do
		res[i] = res[i] or 0
		res[i] = res[i] + 1
		-- c = c + 1
	end
	return res
end

function split2(pString, pPattern)
	local Table = {}  -- NOTE: use {n = 0} in Lua - 5.0
	local fpat = "(.-)" .. pPattern
	local last_end = 1
	local s, e, cap = pString:find(fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(Table, cap)
		end
		last_end = e + 1
		s, e, cap = pString:find(fpat, last_end)
	end
	if last_end <= #pString then
		cap = pString:sub(last_end)
		table.insert(Table, cap)
	end
	return Table
end


function split3(str, sep)
   local result = {}
   local regex = ("([^%s]+)"):format(sep)
   for each in str:gmatch(regex) do
      table.insert(result, each)
   end
   return result
end


function split4(text, delim)
    -- returns an array of fields based on text and delimiter (one character only)
    local result = {}
    local magic = "().%+-*?[]^$"

    if delim == nil then
        delim = "%s"
    elseif string.find(delim, magic, 1, true) then
        -- escape magic
        delim = "%"..delim
    end

    local pattern = "[^"..delim.."]+"
    for w in string.gmatch(text, pattern) do
        table.insert(result, w)
    end
    return result
end